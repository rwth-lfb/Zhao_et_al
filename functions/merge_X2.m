function [redundant, non_redundant, to_merge] = merge_X2(X_vis, F_mean_responses, correlation_threshold, dice_threshold)

%detect relevant overlap between two clusters
num_clusters = size(X_vis,2);
C = zeros(num_clusters, num_clusters);

for(i=1:size(X_vis,2))
    for(j=1:size(X_vis,2))
        in_clus1 = find(X_vis(:,i)==1);
        in_clus2 = find(X_vis(:,j)==1);
        overlap  = length(intersect(in_clus1, in_clus2)); 
        dice     = (2*overlap) / (length(in_clus1)+length(in_clus2));
        
        corr = corrcoef( F_mean_responses(i,:), F_mean_responses(j,:) ); 
        pair_corr = corr(1,2);
        if(dice>=dice_threshold && pair_corr>=correlation_threshold)   
             C(i,j)=1;
        end
    end
end


%add sets of overlapping clusters to 'to_merge'
to_merge = cell(1,1);
counter = 1;
for(i=1:num_clusters)
    this_cluster = find(C(i,:)==1);
    exists = false; %check whether it is already in 'to_merge'
    for(j=1:(counter-1)) 
        c1 = to_merge{j};
        c2 = this_cluster;
        if(sum(ismember(c2,c1))>0)
            exists = true;
        end
    end
    if(~exists)
        to_merge{counter} = this_cluster;
        counter = counter+1;
    end
end


non_redundant = [];
redundant     = [];
remove_list = [];
for(i=1:length(to_merge))
    if(length(to_merge{i})==1) %only self-overlap
        non_redundant = [non_redundant, to_merge{i}];
        remove_list = [remove_list, i];
    else
        redundant = [redundant, to_merge{i}];
    end
end
to_merge(remove_list) = [];
redundant = unique(redundant);
