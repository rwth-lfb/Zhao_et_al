% for plotting with volume_plot(), we need to binarize the images in X
%
function X_vis = binarize_X(X, threshold)

X_vis = zeros(size(X));
X_vis(X>threshold) = 1; 
X_vis = X_vis';