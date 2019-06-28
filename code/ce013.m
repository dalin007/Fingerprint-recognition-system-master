% imaqhwinfo
% obj = videoinput('winvideo');
% set(obj, 'FramesPerTrigger', 1);
% set(obj, 'TriggerRepeat', Inf);
% %定义一个监控界面
% hf = figure('Units', 'Normalized', 'Menubar', 'None','NumberTitle', 'off', 'Name', '实时拍照系统');
% ha = axes('Parent', hf, 'Units', 'Normalized', 'Position', [0.05 0.2 0.85 0.7]);
% axis off
% %定义两个按钮控件
% hb1 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.25 0.05 0.2 0.1], 'String', '预览', 'Callback', ['objRes = get(obj, ''VideoResolution'');' ...
%      'nBands = get(obj, ''NumberOfBands'');' ...
%      'hImage = image(zeros(objRes(2), objRes(1), nBands));' ...
%      'preview(obj, hImage);']);
% hb2 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.55 0.05 0.2 0.1], 'String', '拍照', 'Callback', 'imwrite(getsnapshot(obj), ''im.jpg'')');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % By tennfy
% clear all; clc
% vid = videoinput('winvideo', 1, 'YUY2_640x480');%创建ID为1的摄像头的视频对象，视频格式是 YUY2_640x480，这表示视频的分辨率为640x480。
% set(vid,'ReturnedColorSpace','rgb');
% vidRes=get(vid,'VideoResolution');
% width=vidRes(1);
% height=vidRes(2);
% nBands=get(vid,'NumberOfBands');
% figure('Name', 'Matlab调用摄像头 By tennfy', 'NumberTitle', 'Off', 'ToolBar', 'None', 'MenuBar', 'None');
% hImage=image(zeros(vidRes(2),vidRes(1),nBands));
% preview(vid,hImage);    %打开视频预览窗口
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vid = videoinput('winvideo', 1, 'YUY2_640x480')
% filename = 'film';       %保存视频的名字
% nframe = 120;            %视频的帧数
% nrate = 30;              %每秒的帧数
% % preview(vid);            
% set(1,'visible','off');
%  
vid = videoinput('winvideo', 1, 'YUY2_640x480')
% preview(vid);%%显示摄像头视频内容
% set(vid,'ReturnedColorSpace','grayscale');%设置灰色图像
set(vid,'ReturnedColorSpace','rgb');%设置灰色图像
pause(10)
% frame = getsnapshot(vid);%%截取某时刻摄像头中的画面
% figure;imshow(frame);

% %%%%%%%%%%%%%%%%%%%%%%%%%
%vidRes=get(vid,'VideoResolution');
% width=vidRes(1);
% height=vidRes(2);
% nBands=get(vid,'NumberOfBands');
% hImage=image(zeros(vidRes(2),vidRes(1),nBands));
% filename = 'film';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55 nframe = 120;           
nrate = 30; 
nframe = 120;
filename = 'film';  
writerObj = VideoWriter( [filename '.avi'] );
writerObj.FrameRate = nrate;  
open(writerObj);
 
figure;
for ii = 1: nframe
    frame = getsnapshot(vid);
    imshow(frame);
    f.cdata = frame;
    f.colormap = colormap([]) ;
    writeVideo(writerObj,f);
end
close(writerObj);
% closepreview
