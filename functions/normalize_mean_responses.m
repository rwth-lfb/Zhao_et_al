%wrapper function to normalize mean responses from all animals
%
function F_mean_responses_norm = normalize_mean_responses(F_mean_responses)

num_animals = length(F_mean_responses);

F_mean_responses_norm = cell(num_animals,1);
for(i=1:num_animals)
    F_mean_responses_norm{i} = zscore(F_mean_responses{i},[],2);
end
