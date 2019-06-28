function [o] = adaptiveThres(a,W,noShow);
%Adaptive thresholding is performed by segmenting image a   自适应阈值是通过分割图像a实现的

[w,h] = size(a);%size(a)表示矩阵每个维度的长度
o = zeros(w,h);%w*h的0矩阵

%seperate it to W block把它分离到W区 
%step to w with step length W

for i=1:W:w
for j=1:W:h
mean_thres = 0;

%white is ridge -> large白色是脊—>大

if i+W-1 <= w & j+W-1 <= h
   	mean_thres = mean2(a(i:i+W-1,j:j+W-1)); %mean():求列或行的平均数；mean2：mean(mean(a))
   	%threshold value is choosed选择阈值
      mean_thres = 0.8*mean_thres;
      %before binarization二值化前
      %ridges are black, small intensity value -> 1 (white ridge)脊线是黑色，小强度值—>1(白色脊线)
      %the background and valleys are white, large intensity value -> 0(black)
      %背景和山谷是白色的，大强度值—>0（黑色）
      o(i:i+W-1,j:j+W-1) = a(i:i+W-1,j:j+W-1) < mean_thres;
end;
   
end;
end;


if nargin == 2
imagesc(o);%将矩阵o中的元素数值按大小转换为不同颜色，并对坐标轴对应位置处以这种颜色染色。
colormap(gray);%输出一个灰色系的曲面图
end;
