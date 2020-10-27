%code by: Martin.Strauch@lfb.rwth-aachen.de
%time series --> deltaF/F odor responses 
%
%<reference1>: interval for computing F0, <signal1>: interval for computing F
%>regime1>: odor/measurement number for which the <reference1>, <signal1> intervals are valid
%for all measurements not in <regime1>, the <reference2>,<signal2> intervals apply
%
function mean_responses = to_mean_response2(C_long, intervals, regime1, reference1, signal1, reference2, signal2)

num_time_series = size(C_long,1);
num_stimuli     = length(intervals);
mean_responses  = zeros(num_time_series, num_stimuli);
signal    = signal1; 
reference = reference1; 

epsilon = realmin('single');

for i=1:num_time_series
   
    for j=1:length(intervals)
        
        if(ismember(j,regime1))
            signal=signal1; reference=reference1; 
        else
            signal=signal2; reference=reference2; 
        end
        
        last  = sum(intervals(1:j));
        first = last - intervals(j) + 1;
        
        subset = C_long(i,first:last);
        
        %deltaF:
        F0 = mean(subset(reference));
        F  = mean(subset(signal));
        mean_responses(i,j) = (F-F0)/(F0+epsilon);
       
    end
end
