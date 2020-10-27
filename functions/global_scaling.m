function odor_means_scaled = global_scaling(odor_means, num_colors)

%minimum = min(min(odor_means));
%maximum = max(max(odor_means));

%saturate color scale in the lower/upper range to deal with outliers:
maximum = prctile(reshape(odor_means, size(odor_means,1)*size(odor_means,2),1), 99);
minimum = prctile(reshape(odor_means, size(odor_means,1)*size(odor_means,2),1), 3);

odor_means_scaled = zeros(size(odor_means));
for(i=1:length(odor_means))
    
    odor_means_scaled = 1 + ((odor_means-minimum)./(maximum-minimum)) *(num_colors-1);
end

odor_means_scaled(odor_means_scaled>num_colors)=num_colors;
odor_means_scaled(odor_means_scaled<1)=1;

