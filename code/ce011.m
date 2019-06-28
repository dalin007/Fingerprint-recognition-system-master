[filename,pathname,filter] = uigetfile({'*.tif;*.TIF;*.bmp;*.gif;*.png'},'111');
j=0;
for i=1:length(filename)
    
    if filename(i) == '.'
       j=i;
    end 
end
YY_name = char(zeros(1,j));

for i=1:j-1
    YY_name(i) = filename(i);
end
str = fullfile(pathname,filename);
I=imread(str);
imshow(I);
BS = %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
name = strcat('E:\Desktop\Fingerprint-recognition-system-master\code\picture\',YY_name,BS,'.jpg');
imwrite(I,name)