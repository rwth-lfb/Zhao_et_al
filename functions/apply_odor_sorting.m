% wrapper function that applies reorder_time_series() to all cell entries in F_cc
%
function F_time_series = apply_odor_sorting(F_cc, meta_data)

num_animals = length(F_cc);
F_time_series    = cell(1,num_animals);
for(i=1:num_animals)
    F_time_series{i} = reorder_time_series(F_cc{i}, meta_data);
    %odor sorting, s.t. all animals have the same sequence of odors
end