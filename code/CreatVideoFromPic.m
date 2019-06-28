function CreatVideoFromPic(dn, picformat,aviname)
% CreatVideoFromPic(dn, picformat,aviname)
% 将某个文件夹下某种格式的所有图片合成为视频文件
% dn : 存储图片的文件夹
% picformat : 要读取的图片的格式，如png、jpg等形式，字符串数组
% aviname   : 存储的视频的文件名
% example : CreatVideoFromPic( './', 'png','presentation.avi');

 % CreatVideoFromPic( 'picture_for_video', 'jpg','video\JK.avi')
 
dn =  'E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video';
picformat = 'jpg';
aviname = 'E:\Desktop\Fingerprint-recognition-system-master\code\Email\video\JK.avi'

    if ~exist(dn, 'dir')
        error('dir not exist!!!!');%表明当前目录下存在存储图片的文件
    end
    picname=fullfile( dn, strcat('*.',picformat));  %fullfile构成地址字符串
                                                    %strcat为连接字符串的函数
    picname=dir(picname);%返回指定路径picname所有文件及文件夹组成的列表

    aviobj = VideoWriter(aviname);%定义一个视频文件用来存动画

    open(aviobj);%打开该视频文件
    
     for i=1:length(picname)
      picname(i,1).name = strcat(num2str(i),'.jpg');
     end
  
% for n=1:10     %%图片重复10遍
    for i=1:length(picname)
        picdata=imread( fullfile(dn, (picname(i,1).name)));%从图形文件读取图像
%          picdata=imread( fullfile(dn, strcat(num2str(i),'.jpg')));
%        for v=1:5      %%速度放慢20倍
        if ~isempty( aviobj.Height)  %若aviobj.Height不为空，返回1
            if size(picdata,1) ~= aviobj.Height || size(picdata,2) ~= aviobj.Width
                    %size（picdata,1）返回该矩阵的行数
                     %size(picdata,2) 返回该矩阵的列数
                close(aviobj);
                delete( aviname )
                error('所有图片的尺寸要相同！！');
            end
        end
        writeVideo(aviobj,picdata);%将视频数据写入文件
%         end
    end
% end
    close(aviobj);
end
% --------------------- 
% 作者：Strangers_bye 
% 来源：CSDN 
% 原文：https://blog.csdn.net/u012526003/article/details/52610935 
% 版权声明：本文为博主原创文章，转载请附上博文链接！
