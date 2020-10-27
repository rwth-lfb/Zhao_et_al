%left AL <--> right AL
%flip the ith 3D AL map if the ith flip value in <meta_data> is TRUE
%
function F_cc = flip_ALs (F_cc, meta_data)

if(isfield(meta_data, 'flip_AL'))
    if(length(meta_data.flip_AL) == length(F_cc))
        
        for(i=1:length(meta_data.flip_AL))
            if(strcmp(upper(meta_data.flip_AL{i}),'TRUE'))
                w = F_cc{i}.parameters.width;
                h = F_cc{i}.parameters.height;
                z = F_cc{i}.parameters.number_of_z_slices;
                F_cc{i}.X_vis = flip_X(F_cc{i}.X_vis, w, h, z);
            end
        end
        
    end
end