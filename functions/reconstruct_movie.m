function A = reconstruct_movie(F, channel)

U = F.U{channel};
V = F.V{channel};
S = F.S{channel};

%reconstruct the data from SVD:
A = U*S*V';

