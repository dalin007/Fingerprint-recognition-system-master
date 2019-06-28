function varargout = Fingerprint_recognition(varargin)
%%%%%%%%%%%%love%%%%%%%%%%%%love%%%%%%%%%%%%love%%%%%%%%%%%%
%本文设计了一个指纹识别系统，
%通过对待验证指纹进行指纹预处理、指纹特征点提取后与指纹库中的所有指纹进行匹配，
%若最大的匹配概率大于70%，则语音播放：主人，指纹识别成功；
%反之，语音播放：主人，指纹匹配失败，
%      并伴随有警鸣声，
%      同时系统还会调用电脑自带的摄像头，拍摄当前的视频画面；
%      同时调用MATLAB将拍摄的视频和验证人的指纹图像打包发送到用户的Email；
%点击GUI界面的save按钮，可将当前指纹加入指纹库；
%
%
%*——*——*——*——*——*——*——*——*
%GUI界面解释如下：
%Load：打开验证者的指纹图片
%His-Equalization：对指纹图像进行均衡化处理
%Binarization：对指纹图像二值化处理
%Direction：求指纹图像方向场
%ROI Area：求指纹图像感兴趣区域
%Thining：对指纹图像细化处理
%Remove H breaks：去除指纹图像高频
%Removing spike：去除指纹图像毛刺
%Extract：对指纹特征点进行提取
%Real Minutiae：去除伪特征点后，指纹图像真正的细节
%Match待验证指纹图像与指纹库进行匹配
%save：将该指纹图像加入指纹库
%
%
%
%%%%%%%%%%%%love%%%%%%%%%%%%love%%%%%%%%%%%%love%%%%%%%%%%%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fingerprint_recognition_OpeningFcn, ...
                   'gui_OutputFcn',  @Fingerprint_recognition_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end




function Fingerprint_recognition_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = Fingerprint_recognition_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function varargout = GUI_MAIN_OutputFcn(hObject, eventdata, handles) 
%弹出窗口时就最大化
 javaFrame = get(gcf,'JavaFrame');
 set(javaFrame,'Maximized',1);  
varargout{1} = handles.output;

% 第一步
function pushbutton1_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%添加路径
all_path=genpath('绝对路径');%genpath生成‘’的目标路径
addpath(all_path, '-begin');%addpath将参数中包含的目录添加到工作目录中
savepath;%保存当前搜索路径
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%清空axes内容
axes(handles.axes1) ;  %在其上作图
cla reset  %去除线图，重置坐标轴属性
axes(handles.axes2) ;
cla reset
%%code主体
[filename,pathname,filter] = uigetfile({'*.tif;*.TIF;*.bmp'},'mytitle','E:\Desktop\Fingerprint-recognition-system-master\code\db');
% [filename,pathname,filter] = uigetfile({'*.tif;*.TIF;*.bmp;*.gif;*.png','All Image Files'},'101_1','101_1.tif');
setappdata(0,'filename',filename);%传递参数
str = fullfile(pathname,filename);
w=16;
I=imread(str);

imshow(I,'parent',handles.axes1);
setappdata(0,'I1',I);
set(handles.text2,'String','Load Fingerprint Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=0;
for i=1:length(filename)
    
    if filename(i) == '.'
       j=i;
    end 
end
YY_name = char(zeros(1,j));%zeros创建一个1行j列的全0的矩阵;char()返回字符串结果

for i=1:j-1
    YY_name(i) = filename(i);
end
% str = fullfile(pathname,filename);
% I=imread(str);
% imshow(I);
BS = '_1';
name = strcat('E:\Desktop\Fingerprint-recognition-system-master\code\picture\',YY_name,BS,'.jpg');
imwrite(I,name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
set(handles.text2,'visible','on');
setappdata(0,'w',w);
h=clock;%num2str（A）将A中的数转化为字符串的形式
datetime=strcat('Time：',num2str(h(:,1)),'-',num2str(h(:,2)),'-',num2str(h(:,3)),'---',num2str(h(:,4)),':',num2str(h(:,5)));
set(handles.text4,'String',sprintf(datetime));%将想要的结果输出到指定的字符串中，printf只能输出到命令行
set(handles.text4,'visible','on'); 
setappdata(0,'datetime',datetime);
%%
%语音部分
text2=strcat('主人，当前时间为，北京时间',num2str(num2str(h(:,1))),'年',num2str(h(:,2)),'月',num2str(h(:,3)),'日',num2str(h(:,4)),'点',num2str(h(:,5)),'分');
% text2 = '欢迎狗子主人进行实验，多多加油哦'
fid = fopen('text.txt','w');%fopen()以只写、文本模式打开或创建一个文本文件text.txt
fprintf(fid,'%s\n',text2);%按字符串格式将变量的值输出到指定文件中
fclose(fid);
% winopen('text.txt')
if ispc
    sysCommand = 'python bridge.py';
elseif isunix
    sysCommand = 'python3 brdige.py';%%%
else 
    fprintf('Operating system may not be supported, play answer.wav manually'); 
end 
test_mode = 0;
if test_mode ~= 1 
    [status, res] = system(sysCommand); 
end 

% 第二步 直方图均衡化
function pushbutton2_Callback(hObject, eventdata, handles)
I=getappdata(0,'I1');

I=histeq(uint8(I));
%histq通过直方图均衡化（改变亮度图像灰度值）以增强对比度，以达到输出图像直方图近似于规定的直方图
%数据类型uint8：8位无符号整数，以此种方式存储方式存储的图像称为8位图像，可以节省存储空间。若要显示图像结果，就需要转化为uint8格式。
imshow(I,'parent',handles.axes2);
set(handles.text3,'String','Enhancement by histogram Equalization');
set(handles.text3,'visible','on');
setappdata(0,'I2',I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5aerae
filename=getappdata(0,'filename');
j=0;
for i=1:length(filename)
    
    if filename(i) == '.'
       j=i;
    end 
end
YY_name = char(zeros(1,j));

for i=1:j-1
    YY_name(i) = filename(i);%uiub
end
imshow(I);
BS = '_2';
name = strcat('E:\Desktop\Fingerprint-recognition-system-master\code\picture\',YY_name,BS,'.jpg');
imwrite(I,name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 第三步 二值化
function pushbutton3_Callback(hObject, eventdata, handles)
I=getappdata(0,'I2');
subplot(handles.axes1);
I=adaptiveThres(double(I),32);
set(handles.text2,'String','Adaptive Binarization after FFT');
set(handles.text2,'visible','on');
setappdata(0,'I3',I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename=getappdata(0,'filename');
j=0;
for i=1:length(filename)
    
    if filename(i) == '.'
       j=i;
    end 
end
YY_name = char(zeros(1,j));

for i=1:j-1
    YY_name(i) = filename(i);
end
imshow(I);
BS = '_3';
name = strcat('E:\Desktop\Fingerprint-recognition-system-master\code\picture\',YY_name,BS,'.jpg');
imwrite(I,name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%第4步 方向场
function pushbutton4_Callback(hObject, eventdata, handles)
I=getappdata(0,'I3');
subplot(handles.axes2)
[o1Bound,o1Area]=direction(I,16);


set(handles.text3,'String','Orientation Flow Estimate');
set(handles.text3,'visible','on');
setappdata(0,'I4',I);
setappdata(0,'o1Bound',o1Bound);
setappdata(0,'o1Area',o1Area);

% 第5步 感兴趣区域提取
function pushbutton5_Callback(hObject, eventdata, handles)
I=getappdata(0,'I4');
o1Bound=getappdata(0,'o1Bound');
o1Area=getappdata(0,'o1Area');
subplot(handles.axes1);
[o2,o1Bound,o1Area]=drawROI(I,o1Bound,o1Area);
set(handles.text2,'String','Orientation Flow Estimate');
set(handles.text2,'visible','on');
setappdata(0,'o2',o2);
setappdata(0,'o1Bound',o1Bound);
setappdata(0,'o1Area',o1Area);

% 第6步 细化
function pushbutton6_Callback(hObject, eventdata, handles)
o2=getappdata(0,'o2');
subplot(handles.axes2);
o1=im2double(bwmorph(o2,'thin',Inf));
imagesc(o1,[0,1]);
set(handles.text3,'String','Thinned-ridge map');
set(handles.text3,'visible','on');
setappdata(0,'o1',o1);

% 第7步
function pushbutton7_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
subplot(handles.axes1); 
o1=im2double(bwmorph(o1,'clean'));
o1=im2double(bwmorph(o1,'hbreak'));
imagesc(o1,[0,1]);
set(handles.text2,'String','Remove H breaks');
set(handles.text2,'visible','on');
setappdata(0,'o1',o1);

% 第8步 去毛刺
function pushbutton8_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
subplot(handles.axes2);
o1=im2double(bwmorph(o1,'spur'));%形态学操作
imagesc(o1,[0,1]);
set(handles.text3,'String','remove spike');
set(handles.text3,'visible','on');
setappdata(0,'o1',o1);

% 第9步特征点提取
function pushbutton9_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
o1Bound=getappdata(0,'o1Bound');
o1Area=getappdata(0,'o1Area');
w=getappdata(0,'w');
[end_list1,branch_list1,ridgeMap1,edgeWidth]=mark_minutia(o1,o1Bound,o1Area,w);
subplot(handles.axes1);
show_minutia(o1,end_list1,branch_list1);
set(handles.text2,'String','Minutia');
set(handles.text2,'visible','on');
setappdata(0,'end_list1',end_list1);
setappdata(0,'branch_list1',branch_list1);
setappdata(0,'ridgeMap1',ridgeMap1);
setappdata(0,'edgeWidth',edgeWidth);

% 第10步伪特征点去除
function pushbutton10_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
end_list1=getappdata(0,'end_list1');
branch_list1=getappdata(0,'branch_list1');
o1Area=getappdata(0,'o1Area');
ridgeMap1=getappdata(0,'ridgeMap1');
edgeWidth=getappdata(0,'edgeWidth');
[pathMap1,real_end1,real_branch1]=remove_spurious_Minutia(o1,end_list1,branch_list1,o1Area,ridgeMap1,edgeWidth);
subplot(handles.axes2);
show_minutia(o1,real_end1,real_branch1);
set(handles.text3,'String','Remove spurious minutia');
set(handles.text3,'visible','on');
setappdata(0,'real_end1',real_end1);
setappdata(0,'pathMap1',pathMap1);
save(['E:\Desktop\Fingerprint-recognition-system-master\code\database\the_test_one\middle_test.dat'],'real_end1','pathMap1','-ASCII');

% 第11步 指纹细节点匹配
function pushbutton12_Callback(hObject, eventdata, handles)
pathMap1=getappdata(0,'pathMap1');
%%本算法输出
cd( 'E:\Desktop\Fingerprint-recognition-system-master\code\database\the_test_one\');
finger1=load('middle_test.dat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maindir = 'E:\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one';
subdir  = dir( maindir );%返回指定路径maindir所有文件及文件夹组成的列表
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' )||...%isequal输入数组是否相等，相等返回1；
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % 如果不是目录则跳过
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, '*.dat' );
    dat = dir( subdirpath );            % 子文件夹下找后缀为dat的文件

    for j = 1 : length( dat )
        datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
        fid = fopen( datpath );
        % 此处添加你的对文件读写操作 %
    end
end
num = 0;
  for j = 1 : length( subdir )
      if subdir( j ).bytes >=6000
           disp(subdir( j ).name);%输出数字
           num = num+1;%num表示模板库中指纹的个数
      end
  end
X = string(zeros(num,1));%X表示模板库的指纹
x_num = 0;
  for j = 1 : length( subdir )
      if subdir( j ).bytes >=6000
           x_num =x_num+1;
           X(x_num)= subdir( j ).name;%sbudir(j).name表示模板库的指纹
      end
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%待验证指纹与指纹库进行匹配
cd( 'E:\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one\');
  max_percent=0;
  flag = '000';
    for j = 1 : length( X )
        cd( 'E:\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one\');
      percent_match(j)=match_end(finger1,load(char(X(j))),10);
       if percent_match(j) >= max_percent
             max_percent = percent_match(j);
             flag = X(j);
        else
             max_percent = max_percent;
        end
    end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if max_percent<=70
   text2=strcat('主人指纹不匹配');%strcat 横向连接字符串
   s=1;
else
   text2 = strcat('主人，经过与数据库指纹比对，最大的匹配概率为百分之',num2str(max_percent),'可能是',flag);
   s=0;
end
%语音播放%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('text.txt','w');
fprintf(fid,'%s\n',text2);
fclose(fid);
if ispc
    sysCommand = 'python bridge.py';
elseif isunix
    sysCommand = 'python3 brdige.py';
else 
    fprintf('Operating system may not be supported, play answer.wav manually'); 
end 
test_mode = 0;
if test_mode ~= 1 
    [status, res] = system(sysCommand); 
end 
%%匹配不成功
if s==1
    %报警语音%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [y,Fs]=audioread('E:\Desktop\Fingerprint-recognition-system-master\code\warningsound.WAV');
    sound(y,Fs);
    %记录指纹信息
    I=getappdata(0,'I1');
    imwrite(I,'E:\Desktop\Fingerprint-recognition-system-master\code\Email\zhiwen\XYR.jpg')
    %拍照或视频%%%%%%%%%%%%%%%%%%%%%%%%
    vidobj = videoinput('winvideo',1,'YUY2_640x480');
    nframe = 120;            %视频的帧数
    nrate = 80;              %每秒的帧数
    triggerconfig(vidobj,'manual');
    start(vidobj);
    tic 
    for i = 1:nframe
        snapshot = getsnapshot(vidobj);
        frame = ycbcr2rgb(snapshot);
        imwrite(frame,strcat('E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video\',num2str(i),'.jpg'));
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     CreatVideoFromPic( 'E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video', 'jpg','E:\Desktop\Fingerprint-recognition-system-master\code\Email\video\JK.avi')
    
       dn =  'E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video';
       picformat = 'jpg';
       aviname = 'E:\Desktop\Fingerprint-recognition-system-master\code\Email\video\JK.avi';

    if ~exist(dn, 'dir')
        error('dir not exist!!!!');%表明当前目录下存在存储图片的文件
    end
    picname=fullfile( dn, strcat('*.',picformat));  %fullfile构成地址字符串
                                                    %strcat为连接字符串的函数
    picname=dir(picname);%返回指定路径picname所有文件及文件夹组成的列表

    aviobj = VideoWriter(aviname);%定义一个视频文件用来存动画

    open(aviobj);%打开该视频文件
% for n=1:10     %%图片重复10遍
  for i=1:length(picname)
      picname(i,1).name = strcat(num2str(i),'.jpg');
  end
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

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    stop(vidobj);
    delete(vidobj);  
    close(gcf); 
    %%%%发送邮件
    datetime=getappdata(0,'datetime');
    zip('E:\Desktop\Fingerprint-recognition-system-master\code\Email.zip','E:\Desktop\Fingerprint-recognition-system-master\code\Email')
    sendEmail('报警信息',strcat(datetime,'有人入侵，主人做好报警'),'E:\Desktop\Fingerprint-recognition-system-master\code\Email.zip')
end
                                           
% 第12步 保存
function pushbutton11_Callback(hObject, eventdata, handles)
real_end1=getappdata(0,'real_end1');
pathMap1=getappdata(0,'pathMap1');
textSaveName='file name';
W=inputdlg(textSaveName);%创建并打开输入对话框 
W=char(W);
save(['E:\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one\',W,'.dat'],'real_end1','pathMap1','-ASCII');

%%
%语音
if length(W) ~= 0
   text2=strcat('主人',W,'指纹已保存成功');
else
   text2='主人,指纹未能成功保存';
end
fid = fopen('text.txt','w');
fprintf(fid,'%s\n',text2);
fclose(fid);
if ispc
    sysCommand = 'python bridge.py';
elseif isunix
    sysCommand = 'python3 brdige.py';
else 
    fprintf('Operating system may not be supported, play answer.wav manually'); 
end 
test_mode = 0;
if test_mode ~= 1 
    [status, res] = system(sysCommand); 
end 


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
helpwin Fingerprint_recognition;

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
close(gcf);
