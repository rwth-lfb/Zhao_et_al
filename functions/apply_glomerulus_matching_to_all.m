function matched = apply_glomerulus_matching_to_all(F_time_series, F_mean_responses, F_cc, mapping, mapped_indices, target_index)

num_animals = length(F_cc);
matched     = cell(num_animals,1);

for(i=1:num_animals)
    if(i==target_index)
        matched{i}.F_time_series    = F_time_series{target_index};
        matched{i}.F_mean_responses = F_mean_responses{target_index};
        matched{i}.F_cc             = F_cc{target_index};
        matched{i}.F_cc.X_vis_unmatched = [];
    else
        matched{i}.F_time_series             = F_time_series{i};
        matched{i}.F_time_series.time_series = NaN(size(F_time_series{i}.time_series)); %not size of the target as time series length can differ 
        matched{i}.F_mean_responses          = NaN(size(F_mean_responses{target_index}));
        matched{i}.F_cc = F_cc{i};
       
        indices = mapping{i}(mapped_indices{i}); 
        matched{i}.F_time_series.time_series(mapped_indices{i},:) = F_time_series{i}.time_series(indices,:);
        matched{i}.F_mean_responses(mapped_indices{i},:)          = F_mean_responses{i}(indices,:);
        
        matched{i}.F_cc.X_vis = zeros(size(matched{i}.F_cc.X_vis));
        matched{i}.F_cc.X_vis(:,mapped_indices{i}) = F_cc{i}.X_vis(:,indices);
        
        unmatched = setdiff((1 : size(F_cc{i}.X_vis,2)), indices);
        matched{i}.F_cc.X_vis_unmatched = F_cc{i}.X_vis(:,unmatched);
    end
end

