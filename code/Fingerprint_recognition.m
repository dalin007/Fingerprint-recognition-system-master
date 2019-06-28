function varargout = Fingerprint_recognition(varargin)
%%%%%%%%%%%%love%%%%%%%%%%%%love%%%%%%%%%%%%love%%%%%%%%%%%%
%���������һ��ָ��ʶ��ϵͳ��
%ͨ���Դ���ָ֤�ƽ���ָ��Ԥ����ָ����������ȡ����ָ�ƿ��е�����ָ�ƽ���ƥ�䣬
%������ƥ����ʴ���70%�����������ţ����ˣ�ָ��ʶ��ɹ���
%��֮���������ţ����ˣ�ָ��ƥ��ʧ�ܣ�
%      �������о�������
%      ͬʱϵͳ������õ����Դ�������ͷ�����㵱ǰ����Ƶ���棻
%      ͬʱ����MATLAB���������Ƶ����֤�˵�ָ��ͼ�������͵��û���Email��
%���GUI�����save��ť���ɽ���ǰָ�Ƽ���ָ�ƿ⣻
%
%
%*����*����*����*����*����*����*����*����*
%GUI����������£�
%Load������֤�ߵ�ָ��ͼƬ
%His-Equalization����ָ��ͼ����о��⻯����
%Binarization����ָ��ͼ���ֵ������
%Direction����ָ��ͼ����
%ROI Area����ָ��ͼ�����Ȥ����
%Thining����ָ��ͼ��ϸ������
%Remove H breaks��ȥ��ָ��ͼ���Ƶ
%Removing spike��ȥ��ָ��ͼ��ë��
%Extract����ָ�������������ȡ
%Real Minutiae��ȥ��α�������ָ��ͼ��������ϸ��
%Match����ָ֤��ͼ����ָ�ƿ����ƥ��
%save������ָ��ͼ�����ָ�ƿ�
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
%��������ʱ�����
 javaFrame = get(gcf,'JavaFrame');
 set(javaFrame,'Maximized',1);  
varargout{1} = handles.output;

% ��һ��
function pushbutton1_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���·��
all_path=genpath('����·��');%genpath���ɡ�����Ŀ��·��
addpath(all_path, '-begin');%addpath�������а�����Ŀ¼��ӵ�����Ŀ¼��
savepath;%���浱ǰ����·��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%���axes����
axes(handles.axes1) ;  %��������ͼ
cla reset  %ȥ����ͼ����������������
axes(handles.axes2) ;
cla reset
%%code����
[filename,pathname,filter] = uigetfile({'*.tif;*.TIF;*.bmp'},'mytitle','E:\Desktop\Fingerprint-recognition-system-master\code\db');
% [filename,pathname,filter] = uigetfile({'*.tif;*.TIF;*.bmp;*.gif;*.png','All Image Files'},'101_1','101_1.tif');
setappdata(0,'filename',filename);%���ݲ���
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
YY_name = char(zeros(1,j));%zeros����һ��1��j�е�ȫ0�ľ���;char()�����ַ������

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
h=clock;%num2str��A����A�е���ת��Ϊ�ַ�������ʽ
datetime=strcat('Time��',num2str(h(:,1)),'-',num2str(h(:,2)),'-',num2str(h(:,3)),'---',num2str(h(:,4)),':',num2str(h(:,5)));
set(handles.text4,'String',sprintf(datetime));%����Ҫ�Ľ�������ָ�����ַ����У�printfֻ�������������
set(handles.text4,'visible','on'); 
setappdata(0,'datetime',datetime);
%%
%��������
text2=strcat('���ˣ���ǰʱ��Ϊ������ʱ��',num2str(num2str(h(:,1))),'��',num2str(h(:,2)),'��',num2str(h(:,3)),'��',num2str(h(:,4)),'��',num2str(h(:,5)),'��');
% text2 = '��ӭ�������˽���ʵ�飬������Ŷ'
fid = fopen('text.txt','w');%fopen()��ֻд���ı�ģʽ�򿪻򴴽�һ���ı��ļ�text.txt
fprintf(fid,'%s\n',text2);%���ַ�����ʽ��������ֵ�����ָ���ļ���
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

% �ڶ��� ֱ��ͼ���⻯
function pushbutton2_Callback(hObject, eventdata, handles)
I=getappdata(0,'I1');

I=histeq(uint8(I));
%histqͨ��ֱ��ͼ���⻯���ı�����ͼ��Ҷ�ֵ������ǿ�Աȶȣ��Դﵽ���ͼ��ֱ��ͼ�����ڹ涨��ֱ��ͼ
%��������uint8��8λ�޷����������Դ��ַ�ʽ�洢��ʽ�洢��ͼ���Ϊ8λͼ�񣬿��Խ�ʡ�洢�ռ䡣��Ҫ��ʾͼ����������Ҫת��Ϊuint8��ʽ��
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

% ������ ��ֵ��
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

%��4�� ����
function pushbutton4_Callback(hObject, eventdata, handles)
I=getappdata(0,'I3');
subplot(handles.axes2)
[o1Bound,o1Area]=direction(I,16);


set(handles.text3,'String','Orientation Flow Estimate');
set(handles.text3,'visible','on');
setappdata(0,'I4',I);
setappdata(0,'o1Bound',o1Bound);
setappdata(0,'o1Area',o1Area);

% ��5�� ����Ȥ������ȡ
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

% ��6�� ϸ��
function pushbutton6_Callback(hObject, eventdata, handles)
o2=getappdata(0,'o2');
subplot(handles.axes2);
o1=im2double(bwmorph(o2,'thin',Inf));
imagesc(o1,[0,1]);
set(handles.text3,'String','Thinned-ridge map');
set(handles.text3,'visible','on');
setappdata(0,'o1',o1);

% ��7��
function pushbutton7_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
subplot(handles.axes1); 
o1=im2double(bwmorph(o1,'clean'));
o1=im2double(bwmorph(o1,'hbreak'));
imagesc(o1,[0,1]);
set(handles.text2,'String','Remove H breaks');
set(handles.text2,'visible','on');
setappdata(0,'o1',o1);

% ��8�� ȥë��
function pushbutton8_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
subplot(handles.axes2);
o1=im2double(bwmorph(o1,'spur'));%��̬ѧ����
imagesc(o1,[0,1]);
set(handles.text3,'String','remove spike');
set(handles.text3,'visible','on');
setappdata(0,'o1',o1);

% ��9����������ȡ
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

% ��10��α������ȥ��
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

% ��11�� ָ��ϸ�ڵ�ƥ��
function pushbutton12_Callback(hObject, eventdata, handles)
pathMap1=getappdata(0,'pathMap1');
%%���㷨���
cd( 'E:\Desktop\Fingerprint-recognition-system-master\code\database\the_test_one\');
finger1=load('middle_test.dat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maindir = 'E:\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one';
subdir  = dir( maindir );%����ָ��·��maindir�����ļ����ļ�����ɵ��б�
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' )||...%isequal���������Ƿ���ȣ���ȷ���1��
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % �������Ŀ¼������
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, '*.dat' );
    dat = dir( subdirpath );            % ���ļ������Һ�׺Ϊdat���ļ�

    for j = 1 : length( dat )
        datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
        fid = fopen( datpath );
        % �˴������Ķ��ļ���д���� %
    end
end
num = 0;
  for j = 1 : length( subdir )
      if subdir( j ).bytes >=6000
           disp(subdir( j ).name);%�������
           num = num+1;%num��ʾģ�����ָ�Ƶĸ���
      end
  end
X = string(zeros(num,1));%X��ʾģ����ָ��
x_num = 0;
  for j = 1 : length( subdir )
      if subdir( j ).bytes >=6000
           x_num =x_num+1;
           X(x_num)= subdir( j ).name;%sbudir(j).name��ʾģ����ָ��
      end
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ָ֤����ָ�ƿ����ƥ��
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
   text2=strcat('����ָ�Ʋ�ƥ��');%strcat ���������ַ���
   s=1;
else
   text2 = strcat('���ˣ����������ݿ�ָ�Ʊȶԣ�����ƥ�����Ϊ�ٷ�֮',num2str(max_percent),'������',flag);
   s=0;
end
%��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%ƥ�䲻�ɹ�
if s==1
    %��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [y,Fs]=audioread('E:\Desktop\Fingerprint-recognition-system-master\code\warningsound.WAV');
    sound(y,Fs);
    %��¼ָ����Ϣ
    I=getappdata(0,'I1');
    imwrite(I,'E:\Desktop\Fingerprint-recognition-system-master\code\Email\zhiwen\XYR.jpg')
    %���ջ���Ƶ%%%%%%%%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     CreatVideoFromPic( 'E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video', 'jpg','E:\Desktop\Fingerprint-recognition-system-master\code\Email\video\JK.avi')
    
       dn =  'E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video';
       picformat = 'jpg';
       aviname = 'E:\Desktop\Fingerprint-recognition-system-master\code\Email\video\JK.avi';

    if ~exist(dn, 'dir')
        error('dir not exist!!!!');%������ǰĿ¼�´��ڴ洢ͼƬ���ļ�
    end
    picname=fullfile( dn, strcat('*.',picformat));  %fullfile���ɵ�ַ�ַ���
                                                    %strcatΪ�����ַ����ĺ���
    picname=dir(picname);%����ָ��·��picname�����ļ����ļ�����ɵ��б�

    aviobj = VideoWriter(aviname);%����һ����Ƶ�ļ������涯��

    open(aviobj);%�򿪸���Ƶ�ļ�
% for n=1:10     %%ͼƬ�ظ�10��
  for i=1:length(picname)
      picname(i,1).name = strcat(num2str(i),'.jpg');
  end
    for i=1:length(picname)
        picdata=imread( fullfile(dn, (picname(i,1).name)));%��ͼ���ļ���ȡͼ��
%          picdata=imread( fullfile(dn, strcat(num2str(i),'.jpg')));
%        for v=1:5      %%�ٶȷ���20��
        if ~isempty( aviobj.Height)  %��aviobj.Height��Ϊ�գ�����1
            if size(picdata,1) ~= aviobj.Height || size(picdata,2) ~= aviobj.Width
                    %size��picdata,1�����ظþ��������
                     %size(picdata,2) ���ظþ��������
                close(aviobj);
                delete( aviname )
                error('����ͼƬ�ĳߴ�Ҫ��ͬ����');
            end
        end
        writeVideo(aviobj,picdata);%����Ƶ����д���ļ�
%         end
    end
% end
    close(aviobj);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    stop(vidobj);
    delete(vidobj);  
    close(gcf); 
    %%%%�����ʼ�
    datetime=getappdata(0,'datetime');
    zip('E:\Desktop\Fingerprint-recognition-system-master\code\Email.zip','E:\Desktop\Fingerprint-recognition-system-master\code\Email')
    sendEmail('������Ϣ',strcat(datetime,'�������֣��������ñ���'),'E:\Desktop\Fingerprint-recognition-system-master\code\Email.zip')
end
                                           
% ��12�� ����
function pushbutton11_Callback(hObject, eventdata, handles)
real_end1=getappdata(0,'real_end1');
pathMap1=getappdata(0,'pathMap1');
textSaveName='file name';
W=inputdlg(textSaveName);%������������Ի��� 
W=char(W);
save(['E:\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one\',W,'.dat'],'real_end1','pathMap1','-ASCII');

%%
%����
if length(W) ~= 0
   text2=strcat('����',W,'ָ���ѱ���ɹ�');
else
   text2='����,ָ��δ�ܳɹ�����';
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
