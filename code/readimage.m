function b = readimage(w);
% read the image w
% use the full image for further processes

a=imread(w);
b = double(a);
