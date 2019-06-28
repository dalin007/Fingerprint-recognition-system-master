function [o] = adaptiveThres(a,W,noShow);
%Adaptive thresholding is performed by segmenting image a   ����Ӧ��ֵ��ͨ���ָ�ͼ��aʵ�ֵ�

[w,h] = size(a);%size(a)��ʾ����ÿ��ά�ȵĳ���
o = zeros(w,h);%w*h��0����

%seperate it to W block�������뵽W�� 
%step to w with step length W

for i=1:W:w
for j=1:W:h
mean_thres = 0;

%white is ridge -> large��ɫ�Ǽ���>��

if i+W-1 <= w & j+W-1 <= h
   	mean_thres = mean2(a(i:i+W-1,j:j+W-1)); %mean():���л��е�ƽ������mean2��mean(mean(a))
   	%threshold value is choosedѡ����ֵ
      mean_thres = 0.8*mean_thres;
      %before binarization��ֵ��ǰ
      %ridges are black, small intensity value -> 1 (white ridge)�����Ǻ�ɫ��Сǿ��ֵ��>1(��ɫ����)
      %the background and valleys are white, large intensity value -> 0(black)
      %������ɽ���ǰ�ɫ�ģ���ǿ��ֵ��>0����ɫ��
      o(i:i+W-1,j:j+W-1) = a(i:i+W-1,j:j+W-1) < mean_thres;
end;
   
end;
end;


if nargin == 2
imagesc(o);%������o�е�Ԫ����ֵ����Сת��Ϊ��ͬ��ɫ�������������Ӧλ�ô���������ɫȾɫ��
colormap(gray);%���һ����ɫϵ������ͼ
end;
