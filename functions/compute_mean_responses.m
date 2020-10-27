%wrapper function that applies to_mean_response2() to all entries the cell array F_time_series
%
function F_mean_responses = compute_mean_responses(F_time_series, regime1, regime1_intervals, regime2_intervals)

num_animals = length(F_time_series);
F_mean_responses = cell(1,num_animals);
for(i=1:num_animals) 
    F_mean_responses{i} = to_mean_response2(F_time_series{i}.time_series, F_time_series{i}.measurement_lengths, regime1, regime1_intervals.reference, regime1_intervals.signal, regime2_intervals.reference, regime2_intervals.signal);
    %compute mean odor responses using reference (baseline) and signal (odor response) intervals for two different regimes 
end