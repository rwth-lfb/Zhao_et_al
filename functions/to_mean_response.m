% mean_responses = to_mean_response(C_long{1},intervals{1},[1:20],[30:50]);
% 
function mean_responses = to_mean_response(C_long, intervals, reference, signal)

num_time_series = size(C_long,1);
num_stimuli     = length(intervals);
mean_responses  = zeros(num_time_series, num_stimuli);

epsilon = realmin('single');

for i=1:num_time_series
      
    for j=1:length(intervals)
        last  = sum(intervals(1:j));
        first = last - intervals(j) + 1;
        
        subset = C_long(i,first:last);
         
        %deltaF:
        F0 = mean(subset(reference));
        F  = mean(subset(signal)); 
        mean_responses(i,j) = (F-F0)/(F0+epsilon);
       
    end
end
