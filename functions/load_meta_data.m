function meta_data = load_meta_data(filename)

meta_data = load(filename);
meta_data = meta_data.meta_data;
