clear all; clc
vid = videoinput('winvideo', 1, 'YUY2_640x480');%����IDΪ1������ͷ����Ƶ������Ƶ��ʽ�� YUY2_640x480�����ʾ��Ƶ�ķֱ���Ϊ640x480��
set(vid,'ReturnedColorSpace','rgb');
% vidRes=get(vid,'VideoResolution');
% width=vidRes(1);
% height=vidRes(2);
% nBands=get(vid,'NumberOfBands');
% figure('Name', 'Matlab��������ͷ By tennfy', 'NumberTitle', 'Off', 'ToolBar', 'None', 'MenuBar', 'None');
% hImage=image(zeros(vidRes(2),vidRes(1),nBands));
% preview(vid,hImage);    %����ƵԤ������


filename = 'film';       %������Ƶ������
nframe = 20;            %��Ƶ��֡��
nrate = 50;              %ÿ���֡��
% preview(vid);            
% set(1,'visible','on');
 
writerObj = VideoWriter( [filename '.avi'] );
writerObj.FrameRate = nrate;  
open(writerObj);
 
% % figure;
%     frame = getsnapshot(vid);
% %   imshow(frame);
% %    title('AAA')
%     f.cdata = frame;
    
for ii = 1: nframe
    frame = getsnapshot(vid);
    f.cdata = frame;
    f.colormap = colormap([]) ;
    writeVideo(writerObj,f);
    disp(ii);
end
close(writerObj);
closepreview
close(gcf);
