% ��һ��
function pushbutton1_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���·��
all_path=genpath('����·��');
addpath(all_path, '-begin');
savepath;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%���axes����
axes(handles.axes1) ;
cla reset
axes(handles.axes2) ;
cla reset
%%code����
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
datetime=strcat('Time��',num2str(h(:,1)),'-',num2str(h(:,2)),'-',num2str(h(:,3)),'---',num2str(h(:,4)),':',num2str(h(:,5)));
set(handles.text4,'String',sprintf(datetime));
set(handles.text4,'visible','on'); 
setappdata(0,'datetime',datetime);


% �ڶ���

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

% ������

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

%��4��

I=getappdata(0,'I3');
subplot(handles.axes2)
[o1Bound,o1Area]=direction(I,16);
%%%%%%%%%%%%%%%%%%%%%%%
axes(handles.axes2); %ȡ��axes���ľ��
if isempty(handles.axes2)
   return;
end
newFig = figure;%����ֱ�ӱ���axes1�ϵ�ͼ�������ѣ����Ա������½���figure�е���ͼ
set(newFig,'Visible','off')%�����½���figureΪ���ɼ�
newAxes = copyobj(handles.axes2,newFig);   %��axes1�е�ͼ���Ƶ��½���figure��
set(newAxes,'Units','default','Position','default');    % ����ͼ��ʾ��λ��
[filename,pathname] = uiputfile({ '*.jpg','figure type(*.jpg)'}, '�����Ծ�����','untitled');
if isequal(filename,0)||isequal(pathname,0)%����û�ѡ��ȡ���������˳�
    return;
else
    fpath=fullfile(pathname,filename);
end
imwrite(newFig,fpath);%����û�ѡ��ȡ���������˳�
f = getframe(newFig);
set(newFig,'Visible','off')%�����½���figureΪ���ɼ�
f = frame2im(f);
imwrite(f, fpath);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.text3,'String','Orientation Flow Estimate');
set(handles.text3,'visible','on');
setappdata(0,'I4',I);
setappdata(0,'o1Bound',o1Bound);
setappdata(0,'o1Area',o1Area);
