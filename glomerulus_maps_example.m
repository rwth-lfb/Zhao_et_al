%Computing 3D glomerulus maps from imaging data and matching them between animals
%Code by: Martin.Strauch@lfb.rwth-aachen.de
%--------------------------------------------------------------------------------

%If you already have *.mat files for each animal, proceed directly to point 1)
%Otherwise, see "mat_files_example.m" for how to make these files from tiff stacks.

%1) Compute glomerulus maps from preprocessed movies saved to *.mat files:
%-------------------------------------------------------------------------
addpath('.\functions\');
out_path  = 'I:\human_nonhuman_data\';
meta_data = load_meta_data('human_nonhuman_meta_data.mat');

num_clusters = 40; 
F_cc = compute_glomerulus_maps(out_path,num_clusters, meta_data);

%Plot the 3D glomerulus maps:
for(i=1:length(F_cc))
    figure, volume_plot(F_cc{i}.X_vis, F_cc{i}.parameters);
end


%2) Compute glomerular time series and mean odor responses (heatmaps):
%---------------------------------------------------------------------
F_time_series = apply_odor_sorting(F_cc, meta_data);
%Odorants need to be in the same order for functional matching.
regime1 = 1:28;                         
regime1_intervals.reference = [10:20]; %baseline time points
regime1_intervals.signal    = [30:45]; %odorant response time points
regime2_intervals.reference = [10:100]; 
regime2_intervals.signal    = [190:225];
%1:28 (regime1) are monomolecular odorants, the others (regime2) are blends.
%Recordings in regime1/2 have different lengths/time points at which to extract the mean response.
F_mean_responses = compute_mean_responses(F_time_series, regime1, regime1_intervals, regime2_intervals);

%Visualize mean responses as heatmaps:
for(i=1:length(F_mean_responses))
    show_heatmap(F_time_series{i}.odor_names, F_mean_responses{i});
end

%Merge nearby glomeruli with correlated signals (possible oversegmentation)
correlation_threshold = 0.7; 
%adjacent clusters with a response correlation >= threshold will be merged
for(i=1:length(F_cc))
    [F_time_series{i}, F_mean_responses{i}, F_cc{i}] = merge_redundant_clusters(F_time_series{i}, F_mean_responses{i}, F_cc{i}, correlation_threshold);
end
%Merging variant:
%correlation_threshold = 0.7; overlap_threshold=0.05;
%for(i=1:length(F_cc))
%    [F_time_series{i}, F_mean_responses{i}, F_cc{i}] = merge_redundant_clusters2(F_time_series{i}, F_mean_responses{i}, F_cc{i}, correlation_threshold, overlap_threshold);
%end


%3) Match the glomerulus maps of all animals to one target:
%----------------------------------------------------------
target_index = 3;
constraints.functional_threshold = 0.1; 
constraints.spatial_threshold    = 15; 
%We minimize a combined functional and spatial matching cost.
%Optional constraints serve to forbid implausibly large distances (setting cost=Inf),
%i.e. spatial distances > spatial_threshold, signal correlation < functional_threshold.

responses_train = normalize_mean_responses(extract_odors(F_mean_responses,1:28));
responses_all   = min_max_normalize_mean_responses(F_mean_responses);
%compute matching only on reference odorants ("train")
[mapping_all, mapped_indices_all] = register_all_to_target(responses_train, F_cc, constraints, target_index);
matched = apply_glomerulus_matching_to_all(F_time_series, responses_all, F_cc, mapping_all, mapped_indices_all, target_index);

%Visualize results:
[responses_2D, responses_3D] = combine_responses(matched);
%Heatmap for the average odor responses over all animals:
average_heatmap = mean(responses_3D.responses,3,'omitnan');
show_heatmap(responses_3D.odor_names, average_heatmap);
%PCA space for mean responses:
pca_plot(average_heatmap, responses_3D.odor_names);
%h_: human odour, a_: animal odour, b_: other blend, P,Q,... : monomolecular reference odorants

%3D glomerulus maps with matched colours:
for(i=1:length(matched))
   figure, volume_plot(matched{i}.F_cc.X_vis, matched{i}.F_cc.parameters); 
   hold on; volume_plot(matched{i}.F_cc.X_vis_unmatched, matched{i}.F_cc.parameters,{-37.5, 30, 'gray',1});
end

