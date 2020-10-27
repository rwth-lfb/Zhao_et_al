function pca_plot(responses, odor_names)

[coeff,score,latent,tsquared] = pca(responses, 'NumComponents',3);
figure();
scatter3(coeff(:,1),coeff(:,2),coeff(:,3), '.');
text(coeff(:,1),coeff(:,2),coeff(:,3), odor_names, 'Interpreter', 'none');
set(gcf,'color','w');

