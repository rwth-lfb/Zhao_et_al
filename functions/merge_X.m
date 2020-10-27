function [redundant, non_redundant, to_merge] = merge_X(X_vis, F_mean_responses, correlation_threshold)

overlap_threshold     = 1;

merge_candidates_1 = [];
merge_candidates_2 = [];
merge_1 = [];
merge_2 = [];


for(i=1:size(X_vis,2))
    for(j=1:size(X_vis,2))
        if(i~=j)
            overlap = length(intersect(find(X_vis(:,i)==1), find(X_vis(:,j)==1))); 
            if(overlap>=overlap_threshold)
                if(~pair_exists(merge_candidates_1, merge_candidates_2, i, j)) 
                    merge_candidates_1 = cat(1, merge_candidates_1, i);
                    merge_candidates_2 = cat(1, merge_candidates_2, j);
                end
            end
        end
    end
end

for(i=1:length(merge_candidates_1))      
    corr = corrcoef( F_mean_responses(merge_candidates_1(i),:), F_mean_responses(merge_candidates_2(i),:) ); 
    if( corr(1,2)>=correlation_threshold && ~pair_exists(merge_1, merge_2, merge_candidates_1(i), merge_candidates_2(i)) )
        merge_1 = cat(1, merge_1, merge_candidates_1(i));
        merge_2 = cat(1, merge_2, merge_candidates_2(i));
    end
end

clusters = unique(merge_1);
to_merge = cell(length(clusters),1);
for(i=1:length(to_merge))
    to_merge{i} = clusters(i);
    M = merge_2(find(merge_1==clusters(i)));
    for(j=1:length(M))
        to_merge{i} = cat(1, to_merge{i}, M(j));
    end
end

redundant     = unique([merge_1, merge_2]);
non_redundant = setdiff(1:size(X_vis,2), redundant);