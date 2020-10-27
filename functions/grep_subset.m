function indices = grep_subset(odor_names, grep_string)

is_contained = zeros(length(odor_names),1);

for(i=1:length(odor_names))
    g = regexp(odor_names{i}, grep_string);
    is_contained(i) = length(g);
end

indices = find(is_contained>0);