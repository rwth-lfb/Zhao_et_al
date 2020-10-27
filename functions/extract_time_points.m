function [time_points, measurements] = extract_time_points(measurement_lengths, subset)

time_points  = [];
measurements = [];

count = 1;
start = 1; 
for(i=1:length(measurement_lengths))
    stop = start + measurement_lengths(i)-1;
    
    if(any(subset==i))
        time_points  = cat(1, time_points, [start:stop]');
        measurements = cat(1, measurements, ones(length([start:stop]),1)*count);
        count=count+1;
    end
    
    start = stop+1;
end