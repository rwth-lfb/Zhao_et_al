%code by: Martin.Strauch@lfb.rwth-aachen.de
%
function [U, S, V, means, names, parameters] = read_and_preprocess_orco(folder, files_to_read, width, height, number_of_z_slices, reference_interval, gauss_sd, kernel_size)

num_channels        = 1;
all_tiffs           = dir([folder, files_to_read]);

names               = [];
measurement_lengths = [];
M1                  = [];
M2                  = [];
means = cell(2,1); 
stds  = cell(2,1);

disp(folder);
for i=1:length(all_tiffs)
    disp(i);
    this_stack       = read_tiff_stack(strcat(folder,all_tiffs(i).name)); 
    num_time_points  = size(this_stack,3)/(num_channels*number_of_z_slices);
    this_stack       = single(reshape_stack(this_stack, width, height, num_channels, number_of_z_slices, num_time_points));
    
    this_channel1    = squeeze(this_stack(:,:,1,:,:));
    clear this_stack;
     
    %spatial and temporal filtering:
    for(j=1:size(this_channel1,4))
         this_channel1(:,:,:,j) = imgaussfilt3(this_channel1(:,:,:,j), gauss_sd, 'FilterSize', kernel_size, 'FilterDomain', 'spatial', 'Padding', 'replicate');
    end
    
    window_size=10; 
    for j=1:size(this_channel1,1)
        for a=1:size(this_channel1,2)
            for b=1:size(this_channel1,3)
                this_channel1(j,a,b,:) = smooth(this_channel1(j,a,b,:), window_size);
            end
        end
    end
    
    %compute and subtract mean activity during the reference interval
    mean1 = single(mean(this_channel1(:,:,:,reference_interval),4));
    
    if(i==1)
        means{1} = mean1; 
    else
        means{1} = cat(3, means{1}, mean1);
    end
    
    %this_channel1       = this_channel1 - mean1;
      
    M1                  = cat(4, M1, this_channel1);
    names               = cat(1,names, all_tiffs(i).name);
    measurement_lengths = cat(1, measurement_lengths, num_time_points);
end



size(M1)
M1 = reshape(M1,width*height*number_of_z_slices, sum(measurement_lengths));

disp('SVD');
U = cell(2,1); V=cell(2,1); S = cell(2,1);
[U{1}, S{1}, V{1}] = svd(M1, 'econ'); %dimensionality reduction with SVD


parameters.width               = width;
parameters.height              = height;
parameters.number_of_z_slices  = number_of_z_slices;
parameters.reference_interval  = reference_interval;
parameters.folder              = folder;
parameters.measurement_lengths = measurement_lengths;
parameters.gauss_kernel        = kernel_size;
parameters.gauss_sd            = gauss_sd;
parameters.odor_names          = names;
 
