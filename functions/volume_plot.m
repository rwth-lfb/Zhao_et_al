%code by: Martin.Strauch@lfb.rwth-aachen.de
%
function volume_plot(X, parameters, graphics_options)

w = parameters.width;
h = parameters.height;
num_slices = parameters.number_of_z_slices;
alpha_value = 0.75;

if exist('graphics_options','var')
    azimuth = graphics_options{1};
    elevation = graphics_options{2};
    color = graphics_options{3};
    smoothing = graphics_options{4};
else
    azimuth =  -37.5;
    elevation = 30;
    %from the documentation for Matlab's view():
    %azimuth: "the horizontal rotation about the z-axis as measured in degrees from the negative y-axis. Positive values indicate counterclockwise rotation of the viewpoint. "
    %elevation: "vertical elevation of the viewpoint in degrees. Positive values of elevation correspond to moving above the object; negative values correspond to moving below the object."
    color = 'color'; %either 'color' or 'gray'
    smoothing = 15;
end

rng(42);
map=distinguishable_colors(size(X,2),'w');

if(strcmp(color,'gray'))
    map = colormap(gray);
    alpha_value = 0.1;
end
map = [map; map; map];

for i=1:size(X,2)
    
    temp = reshape(X(:,i),w,h,num_slices);
    [x,y,z] = ind2sub(size(temp),find(temp==1));
    shape = alphaShape(x,y,z);
    shape.Alpha = smoothing;
    p=plot(shape);
    set(p, 'FaceColor',map(i,:), 'EdgeColor','none', 'FaceAlpha', alpha_value);  
    hold on;   
end


daspect([1 1 1])           
view(azimuth, elevation);
axis vis3d tight, box on, grid on    
camproj perspective                           
if(strcmp(color,'color'))
    camlight 
    lighting phong
end

xlim([1,w]);
ylim([1,h]);
zlim([1,num_slices]);




