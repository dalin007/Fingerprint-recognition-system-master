vid = videoinput('winvideo', 1, 'YUY2_640x480')
% preview(vid);%%��ʾ����ͷ��Ƶ����
% set(vid,'ReturnedColorSpace','grayscale');%���û�ɫͼ��
set(vid,'ReturnedColorSpace','rgb');%���û�ɫͼ��
pause(10)
frame = getsnapshot(vid);%%��ȡĳʱ������ͷ�еĻ���
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