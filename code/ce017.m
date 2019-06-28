clear all; clc
vid = videoinput('winvideo', 1, 'YUY2_640x480');%创建ID为1的摄像头的视频对象，视频格式是 YUY2_640x480，这表示视频的分辨率为640x480。
set(vid,'ReturnedColorSpace','rgb');
% vidRes=get(vid,'VideoResolution');
% width=vidRes(1);
% height=vidRes(2);
% nBands=get(vid,'NumberOfBands');
% figure('Name', 'Matlab调用摄像头 By tennfy', 'NumberTitle', 'Off', 'ToolBar', 'None', 'MenuBar', 'None');
% hImage=image(zeros(vidRes(2),vidRes(1),nBands));
% preview(vid,hImage);    %打开视频预览窗口


filename = 'film';       %保存视频的名字
nframe = 20;            %视频的帧数
nrate = 50;              %每秒的帧数
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
