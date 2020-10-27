function animal = load_animal(filename)

load(filename);

animal.U = U;
animal.V = V;
animal.S = S;
animal.baselines = baselines;
animal.names = names;
animal.parameters = parameters;


