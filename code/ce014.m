vid = videoinput('winvideo', 1, 'YUY2_640x480')
% preview(vid);%%显示摄像头视频内容
% set(vid,'ReturnedColorSpace','grayscale');%设置灰色图像
set(vid,'ReturnedColorSpace','rgb');%设置灰色图像
pause(10)
frame = getsnapshot(vid);%%截取某时刻摄像头中的画面
figure;imshow(frame);          
% nrate = 30; 
% nframe = 120;
% filename = 'film';  
% writerObj = VideoWriter( [filename '.avi'] );
% writerObj.FrameRate = nrate;  
% open(writerObj);
% figure;
% for ii = 1: nframe
%     frame = getsnapshot(vid);
%     imshow(frame);
%     f.cdata = frame;
%     f.colormap = colormap([]) ;
%     writeVideo(writerObj,f);
% end
% close(writerObj);