function [responses_2D, responses_3D] = combine_responses(matched)

names = matched{1}.F_time_series.odor_names;

M2=[]; 
M3=[]; 
name_vec=[];

for(i=1:length(matched))
    this_AL = matched{i}.F_mean_responses;
    M2 = cat(2, M2, this_AL);
    M3 = cat(3,M3, this_AL);
    name_vec = cat(1, name_vec, names);
end

responses_2D.responses  = M2;
responses_2D.odor_names = name_vec;

responses_3D.responses  = M3;
responses_3D.odor_names = names;