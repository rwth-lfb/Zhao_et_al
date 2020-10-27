%Time series in F.C will be reordered, s.t. all animals have the same sequence of odors
%
function time_series = reorder_time_series(F, meta_data)

C = F.C;

this_animal_name  = F.parameters.measurement_name;
this_animal_index = find(strcmp(meta_data.animal_names, this_animal_name));

odor_names = meta_data.odor_names{this_animal_index};
lengths    = F.parameters.measurement_lengths; 

[odor_names_sorted, sorting_indices] = sort(odor_names);

time_series.time_series         = C;
time_series.odor_names          = odor_names_sorted;
time_series.measurement_lengths = lengths(sorting_indices);

for(i=1:size(C,1))
    time_series.time_series(i,:) = split_and_reorder(time_series.time_series(i,:), lengths, sorting_indices); 
end
