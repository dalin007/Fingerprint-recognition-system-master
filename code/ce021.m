% 第一步
function pushbutton1_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%添加路径
all_path=genpath('绝对路径');
addpath(all_path, '-begin');
savepath;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%清空axes内容
axes(handles.axes1) ;
cla reset
axes(handles.axes2) ;
cla reset
%%code主体
[filename,pathname,filter] = uigetfile({'*.tif;*.TIF'},'mytitle','E:\Desktop\Fingerprint-recognition-system-master\code\db');
% [filename,pathname,filter] = uigetfile({'*.tif;*.TIF;*.bmp;*.gif;*.png','All Image Files'},'101_1','101_1.tif');
setappdata(0,'filename',filename);
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
YY_name = char(zeros(1,j));

for i=1:j-1
    YY_name(i) = filename(i);
end
str = fullfile(pathname,filename);
% I=imread(str);
% imshow(I);
BS = '_1';
name = strcat('E:\Desktop\Fingerprint-recognition-system-master\code\picture\',YY_name,BS,'.jpg');
imwrite(I,name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
set(handles.text2,'visible','on');
setappdata(0,'w',w);
h=clock;
datetime=strcat('Time：',num2str(h(:,1)),'-',num2str(h(:,2)),'-',num2str(h(:,3)),'---',num2str(h(:,4)),':',num2str(h(:,5)));
set(handles.text4,'String',sprintf(datetime));
set(handles.text4,'visible','on'); 
setappdata(0,'datetime',datetime);


% 第二步

I=getappdata(0,'I1');

I=histeq(uint8(I));
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

% 第三步

I=getappdata(0,'I2');
subplot(handles.axes1);
I=adaptiveThres(double(I),32);
set(handles.text2,'String','Adaptive Binarization after FFT');
set(handles.text2,'visible','on');
setappdata(0,'I3',I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
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

%第4步

I=getappdata(0,'I3');
subplot(handles.axes2)
[o1Bound,o1Area]=direction(I,16);
%%%%%%%%%%%%%%%%%%%%%%%
axes(handles.axes2); %取得axes１的句柄
if isempty(handles.axes2)
   return;
end
newFig = figure;%由于直接保存axes1上的图像有困难，所以保存在新建的figure中的谱图
set(newFig,'Visible','off')%设置新建的figure为不可见
newAxes = copyobj(handles.axes2,newFig);   %将axes1中的图复制到新建的figure中
set(newAxes,'Units','default','Position','default');    % 设置图显示的位置
[filename,pathname] = uiputfile({ '*.jpg','figure type(*.jpg)'}, '保存试井曲线','untitled');
if isequal(filename,0)||isequal(pathname,0)%如果用户选择“取消”，则退出
    return;
else
    fpath=fullfile(pathname,filename);
end
imwrite(newFig,fpath);%如果用户选择“取消”，则退出
f = getframe(newFig);
set(newFig,'Visible','off')%设置新建的figure为不可见
f = frame2im(f);
imwrite(f, fpath);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.text3,'String','Orientation Flow Estimate');
set(handles.text3,'visible','on');
setappdata(0,'I4',I);
setappdata(0,'o1Bound',o1Bound);
setappdata(0,'o1Area',o1Area);
