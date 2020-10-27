function F_mean_responses_subset = extract_odors(F_mean_responses, odor_subset)

F_mean_responses_subset = F_mean_responses;

for(i=1:length(F_mean_responses))
    F_mean_responses_subset{i} = F_mean_responses{i}(:,odor_subset);
end