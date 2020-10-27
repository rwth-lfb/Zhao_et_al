function [F_time_series, F_mean_responses, F_cc] = merge_redundant_clusters2(F_time_series, F_mean_responses, F_cc, correlation_threshold, dice_threshold)

[redundant, non_redundant, to_merge] = merge_X2(F_cc.X_vis, F_mean_responses, correlation_threshold, dice_threshold);

if(length(to_merge)>0)
    merged = merge_clusters(F_cc.X_vis, F_time_series, F_mean_responses, to_merge);
    F_cc.X_vis       = cat(2, merged.X_vis, F_cc.X_vis(:, non_redundant));
    F_mean_responses = cat(1, merged.F_mean_responses,  F_mean_responses(non_redundant,:));
    F_time_series.time_series = cat(1, merged.time_series, F_time_series.time_series(non_redundant,:));
end


