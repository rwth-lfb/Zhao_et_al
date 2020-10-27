% code by: Martin.Strauch@lfb.rwth-aachen.de
%
% Optimizes glomerulus assignment between two animals according to both spatial distance and functional (odor response) distance.
% The subject animal with odor responses in F_mean_responses_norm{subject_index} and 3D glomerluus map in F_cc{subject_index} is registered to the target animal.
% constraints.functional_threshold, constraints.spatial_threshold can be set to a number or to "off"
%
function [subject, target, mapping, mapped_indices] = register_animals(F_mean_responses_norm, F_cc, constraints, target_index, subject_index)

%Currently, spatial and functional distance contribute eequally to the cost of the registration:
spatial_weight    = 1;
functional_weight = 1;

subject.mean_responses = F_mean_responses_norm{subject_index};
subject.movie = F_cc{subject_index};
target.mean_responses  = F_mean_responses_norm{target_index};
target.movie  = F_cc{target_index};

[mapping, mapped_indices, cost] = find_closest_match(subject.mean_responses, target.mean_responses, subject.movie.X_vis, target.movie.X_vis, spatial_weight, functional_weight, constraints.spatial_threshold, constraints.functional_threshold, target.movie.parameters); 



