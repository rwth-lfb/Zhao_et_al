function merged = merge_clusters(X_vis, F_time_series, F_mean_responses, to_merge)

le = length(to_merge);
merged.X_vis = zeros(size(X_vis,1), le);
merged.F_mean_responses = zeros(le, size(F_mean_responses,2));
merged.time_series = zeros(le, size(F_time_series.time_series,2));

for(i=1:le)
    for(j=1:length(to_merge{i}))
        merged.X_vis(:,i) = merged.X_vis(:,i) + X_vis(:,to_merge{i}(j));
        merged.F_mean_responses(i,:) = merged.F_mean_responses(i,:) + F_mean_responses(to_merge{i}(j),:);
        merged.time_series(i,:)      = merged.time_series(i,:) + F_time_series.time_series(to_merge{i}(j),:);
    end
    merged.F_mean_responses(i,:) = merged.F_mean_responses(i,:)/length(to_merge{i});
    merged.time_series(i,:)      = merged.time_series(i,:)/length(to_merge{i});
end