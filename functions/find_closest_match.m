% code by: Martin.Strauch@lfb.rwth-aachen.de
%
% Input:
% <C1>: glomerulus time series and <X1>: glomerulus clusters for animal1
% <C2>: glomerulus time series and <X2>: glomerulus clusters for animal2
% <w_spatial>, <w_functional>: weights for the spatial and functional distance, respectively
% <spatial_threshold>: spatial distances between matched glomeruli greater than this are not allowed
% <functional_threshold>: odor response correlations between matched glomeruli are not allowed to be lower than this
% set <spatial_threshold> = -1 or <functional_threshold> = -1 --> then the respective constraint is not used
% <parameters>: from movie_object.parameters (contains: parameters.width, parameters.height, parameters.number_of_z_slices)
%
% Output:
% <mapping> of animal1 glomeruli to animal2 glomeruli ("0" means that a glomerulus could not be mapped)
% <mapped_indices>: indices that are not "0", i.e. that could be mapped succesfully
% <cost> of the optimized mapping
%
function [mapping, mapped_indices, cost] = find_closest_match(C1,C2,X1,X2, w_spatial, w_functional, spatial_threshold, functional_threshold, parameters)

%z_factor    = 1;
z_factor    = 4; %possibility to compensate lower z-resolution by scaling up the z-axis

width1      = parameters.width; 
height1     = parameters.height;
num_slices1 = parameters.number_of_z_slices;
width2      = width1; %could be different in a later version
height2     = height1; 
num_slices2 = num_slices1;

C1=C1';
C2=C2';

pattern_dist = zeros(size(X1,2),size(X2,2));
spatial_dist = zeros(size(X1,2),size(X2,2));
corr_matrix  = zeros(size(X1,2),size(X2,2));

for i=1:size(X1,2)
    for j=1:size(X2,2)
        pattern_dist(i,j) = sqrt(sum((C1(:,i) - C2(:,j)).^2));
       
        corr_matrix(i,j) = corr(C1(:,i), C2(:,j));
        
        X1_component = reshape(X1(:,i),width1,height1,num_slices1);
        [x1,y1,z1] = ind2sub(size(X1_component),find(X1_component==1));
       
        X2_component = reshape(X2(:,j),width2,height2,num_slices2);
        [x2,y2,z2] = ind2sub(size(X2_component),find(X2_component==1));
             
        spatial_dist(i,j) = sqrt((mean(x1)-mean(x2))^2 + (mean(y1)-mean(y2))^2 + (z_factor*(mean(z1)-mean(z2)))^2);
    end
end

spatial_dist_orig = spatial_dist;

pattern_dist = (pattern_dist - mean(mean(pattern_dist))); 
spatial_dist = (spatial_dist - mean(mean(spatial_dist))); 

%possibility to include constraints:
if(~strcmp(lower(spatial_threshold), 'off'))
    spatial_dist(spatial_dist_orig>spatial_threshold)= Inf;  
end
if(~strcmp(lower(functional_threshold), 'off'))
    pattern_dist(corr_matrix<functional_threshold)=Inf; 
end
%

dist = pattern_dist*w_spatial + spatial_dist*w_functional;

[mapping,cost] = munkres(dist');

mapped_indices = find(mapping>0);