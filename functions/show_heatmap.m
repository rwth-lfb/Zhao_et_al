function show_heatmap(names, F_mean_responses)

num_colors = 4096;
color_map  = CubeHelix(num_colors,0.5,-1.5,1.2,1.0);
the_image  = global_scaling(F_mean_responses, num_colors);

alpha = ones(size(the_image));
alpha(isnan(the_image)) = 0;

figure();
imagesc(the_image,'AlphaData',alpha);
colormap(color_map);
colorbar();
set(gca, 'color', [0.7 0.7 0.7 0.7]); %NaN color

xticks(1:length(names)); 
xticklabels(names); 
xtickangle(90); 
set(gca,'TickLabelInterpreter','none'); 
set(gcf,'color','w');
set(gca,'TickLength',[0 0]);

