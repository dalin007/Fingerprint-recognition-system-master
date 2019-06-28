clear all; close all; clc;

% MATLAB��������ͷ����

% ��ȡ�������Ѿ���װ��Ӳ����Դ�б�

imaqhwinfo;

info=imaqhwinfo('winvideo') ;

dev_info=imaqhwinfo('winvideo',1);

dev_info.SupportedFormats

dev_info.SupportedFormats(8);

% ����videoinput����

vidobj = videoinput('winvideo',1,'RGB24_1280x720');

% ��������

set(vidobj, 'FramesPerTrigger', 1);

set(vidobj, 'TriggerRepeat', Inf);

vidobj.FrameGrabInterval = 1; 

vidobj_src = getselectedsource(vidobj);

preview(vidobj);



for i = 1:2000

     frame = getsnapshot(vidobj); 

     format short g;

     t=clock; h=num2str(t(4)); s=num2str(t(5));  %��ȡ��ǰʱ���ʱ����

     imwrite(frame,[h,s,'.jpg']);  %��ʱ����Ϊ�ļ�������ͼ��

     pause(60);    %��ͣ60�룬����ÿ��1���Ӳɼ�ͼ��1��

end  
stop(vidobj);
delete(vidobj);  
disp('end');

