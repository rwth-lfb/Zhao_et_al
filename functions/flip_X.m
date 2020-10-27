function X = flip_X(X, x, y, z)

for(i = 1:size(X,2))
    
   X_r = reshape(X(:,i), x, y, z);
   for(j = 1:z)
        X_r(:,:,j) = flip(X_r(:,:,j),1);
   end
   X(:,i) = reshape(X_r, x*y*z,1);
end