function J = min_max_normalize(I)

I = double(I);
minimum = min(min(I));
maximum = max(max(I));

J = (I - minimum) ./ (maximum - minimum);

