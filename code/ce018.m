vidobj = videoinput('winvideo',1,'YUY2_640x480');
nframe = 120;            %��Ƶ��֡��
nrate = 80;              %ÿ���֡��
triggerconfig(vidobj,'manual');
start(vidobj);
tic 
for i = 1:nframe
     snapshot = getsnapshot(vidobj);
     frame = ycbcr2rgb(snapshot);
     imwrite(frame,strcat('E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video\',num2str(i),'.jpg'));
end
CreatVideoFromPic( 'picture_for_video', 'jpg','video\JK.avi')
stop(vidobj);
delete(vidobj);  
close(gcf);

