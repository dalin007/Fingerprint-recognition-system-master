% imaqhwinfo
% obj = videoinput('winvideo');
% set(obj, 'FramesPerTrigger', 1);
% set(obj, 'TriggerRepeat', Inf);
% %����һ����ؽ���
% hf = figure('Units', 'Normalized', 'Menubar', 'None','NumberTitle', 'off', 'Name', 'ʵʱ����ϵͳ');
% ha = axes('Parent', hf, 'Units', 'Normalized', 'Position', [0.05 0.2 0.85 0.7]);
% axis off
% %����������ť�ؼ�
% hb1 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.25 0.05 0.2 0.1], 'String', 'Ԥ��', 'Callback', ['objRes = get(obj, ''VideoResolution'');' ...
%      'nBands = get(obj, ''NumberOfBands'');' ...
%      'hImage = image(zeros(objRes(2), objRes(1), nBands));' ...
%      'preview(obj, hImage);']);
% hb2 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.55 0.05 0.2 0.1], 'String', '����', 'Callback', 'imwrite(getsnapshot(obj), ''im.jpg'')');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % By tennfy
% clear all; clc
% vid = videoinput('winvideo', 1, 'YUY2_640x480');%����IDΪ1������ͷ����Ƶ������Ƶ��ʽ�� YUY2_640x480�����ʾ��Ƶ�ķֱ���Ϊ640x480��
% set(vid,'ReturnedColorSpace','rgb');
% vidRes=get(vid,'VideoResolution');
% width=vidRes(1);
% height=vidRes(2);
% nBands=get(vid,'NumberOfBands');
% figure('Name', 'Matlab��������ͷ By tennfy', 'NumberTitle', 'Off', 'ToolBar', 'None', 'MenuBar', 'None');
% hImage=image(zeros(vidRes(2),vidRes(1),nBands));
% preview(vid,hImage);    %����ƵԤ������
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vid = videoinput('winvideo', 1, 'YUY2_640x480')
% filename = 'film';       %������Ƶ������
% nframe = 120;            %��Ƶ��֡��
% nrate = 30;              %ÿ���֡��
% % preview(vid);            
% set(1,'visible','off');
%  
vid = videoinput('winvideo', 1, 'YUY2_640x480')
% preview(vid);%%��ʾ����ͷ��Ƶ����
% set(vid,'ReturnedColorSpace','grayscale');%���û�ɫͼ��
set(vid,'ReturnedColorSpace','rgb');%���û�ɫͼ��
pause(10)
% frame = getsnapshot(vid);%%��ȡĳʱ������ͷ�еĻ���
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
