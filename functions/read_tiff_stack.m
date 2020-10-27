function M = read_tiff_stack(filename)

info      = imfinfo(filename);
frames    = length(info);
width     = info.Width;
height    = info.Height;
tiff_link = Tiff(filename,'r');

M         = single(zeros(height, width,frames));
for i = 1:frames
     tiff_link.setDirectory(i);
     M(:,:,i) = single(tiff_link.read());
end  
