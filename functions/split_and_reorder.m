%split the time_series in C into the individual measurements and reorder according to the <sorting_indices>
%
function C_reordered = split_and_reorder(C, measurement_lengths, sorting_indices)

measurements = cell(1,length(measurement_lengths));

start = 1;
stop  = measurement_lengths(1);
measurements{1} = C(start:stop);

for(i = 2:(length(measurement_lengths)))
    
    start = sum(measurement_lengths(1:(i-1))) + 1;
    stop  = sum(measurement_lengths(1:(i)));
    
    measurements{i} = C(start:stop);
end

measurements = measurements(sorting_indices);

C_reordered = [];
for(i = 1:length(measurements))
    C_reordered = cat(1, C_reordered, measurements{i}'); 
end
C_reordered = C_reordered';




