function reshaped = reshape_stack(stack, width, height, num_channels, number_of_z_slices, num_time_points)

reshaped = single(zeros(width, height, num_channels, number_of_z_slices, num_time_points));

counter = 0;
for(i=1:num_time_points)
    for(j=1:number_of_z_slices)
        for(k=1:num_channels)
            counter = counter +1;
            reshaped(:,:,k,j,i) = stack(:,:,counter);
        end
    end
end