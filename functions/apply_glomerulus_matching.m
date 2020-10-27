function matched_animal = apply_glomerulus_matching(F_time_series, F_mean_responses, F_cc, mapping, mapped_indices, subject_target, animal_index)

F_time_series    = F_time_series{animal_index};
F_mean_responses = F_mean_responses{animal_index};
F_cc             = F_cc{animal_index};

new_F_time_series    = F_time_series;
new_F_mean_responses = F_mean_responses;
new_F_cc = F_cc;
unmatched = [];

if(strcmp(subject_target, 'subject'))
    new_F_cc.X_vis       = F_cc.X_vis(:, mapping(mapped_indices));
    new_F_mean_responses = F_mean_responses(mapping(mapped_indices),:);
    new_F_time_series.time_series = F_time_series.time_series(mapping(mapped_indices),:);
    
    unmatched = setdiff((1 : size(F_cc.X_vis,2)), mapping(mapped_indices));
end
    
if(strcmp(subject_target, 'target'))
    new_F_cc.X_vis       = F_cc.X_vis(:, mapped_indices);
    new_F_mean_responses = F_mean_responses(mapped_indices,:);
    new_F_time_series.time_series = F_time_series.time_series(mapped_indices,:);
    
    unmatched = setdiff((1 : size(F_cc.X_vis,2)), mapped_indices);
end

matched_animal.F_time_series = new_F_time_series;
matched_animal.F_mean_responses = new_F_mean_responses;
matched_animal.F_cc = new_F_cc;
matched_animal.F_cc.X_vis_unmatched = F_cc.X_vis(:,unmatched);



