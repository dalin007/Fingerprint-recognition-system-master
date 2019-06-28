clear all; close all; clc;

% MATLAB控制摄像头操作

% 获取本机中已经安装的硬件资源列表

imaqhwinfo;

info=imaqhwinfo('winvideo') ;

dev_info=imaqhwinfo('winvideo',1);

dev_info.SupportedFormats

dev_info.SupportedFormats(8);

% 建立videoinput对象

vidobj = videoinput('winvideo',1,'RGB24_1280x720');

% 设置属性

set(vidobj, 'FramesPerTrigger', 1);

set(vidobj, 'TriggerRepeat', Inf);

vidobj.FrameGrabInterval = 1; 

vidobj_src = getselectedsource(vidobj);

preview(vidobj);



for i = 1:2000

     frame = getsnapshot(vidobj); 

     format short g;

     t=clock; h=num2str(t(4)); s=num2str(t(5));  %获取当前时间的时、分

     imwrite(frame,[h,s,'.jpg']);  %以时、分为文件名保存图像

     pause(60);    %暂停60秒，即可每隔1分钟采集图像1次

end  
stop(vidobj);
delete(vidobj);  
disp('end');

