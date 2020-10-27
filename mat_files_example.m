%Read and preprocess the individual tiff files. 
%
%This is a time-consuming step that needs to be carried out only once.
%Results are then saved as one *.mat file per animal: 
%These files are much smaller and easier to handle than the orignal tiff files.

addpath('.\functions\');
in_path   = 'D:\human_non_human_tiffs\'; %folder with *.tiff files
out_path  = 'I:\human_nonhuman_data\';   %folder to save the *.mat files to
subfolder = 'odorEvoked'; %there can be subfolders for odorant responses, spontaneous activity etc.
files_to_read = '*-mc.tif.registered.tif'; %specify ending of the files to read

stack_dimensions   = [128,128,24]; %[x,y,z]
reference_interval = 1:20; %time points at the beginning of a movie, before odour stimulation

gauss_sd    = [6,6,1.5];
kernel_size = [41,41,11];
%standard deviation and kernel size for the Gauss filter 
%(separately for [x,y,z] dimensions as z-resolution is lower)

process_folder_orco(in_path, subfolder, files_to_read, out_path, stack_dimensions, reference_interval, gauss_sd, kernel_size); 
