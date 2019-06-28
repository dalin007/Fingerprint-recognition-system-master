function varargout = GUI1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI1_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before GUI1 is made visible.
function GUI1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI1 (see VARARGIN)

% Choose default command line output for GUI1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% 第一步
function pushbutton1_Callback(hObject, eventdata, handles)
[filename,pathname,filter] = uigetfile({'*.tif;*.TIF;*.bmp;*.gif;*.png'},'选择图片');
str = fullfile(pathname,filename);
w=16
I=imread(str);
imshow(I,'parent',handles.axes1);
setappdata(0,'I1',I);
set(handles.text2,'String','Load Fingerprint Image');
set(handles.text2,'visible','on');
setappdata(0,'w',w);
h=clock;
datetime=strcat('Time：',num2str(h(:,1)),'-',num2str(h(:,2)),'-',num2str(h(:,3)),'---',num2str(h(:,4)),':',num2str(h(:,5)));
set(handles.text4,'String',sprintf(datetime));
set(handles.text4,'visible','on'); 
%%
%语音部分
text2=strcat('狗子主人，当前时间为，北京时间',num2str(num2str(h(:,1))),'年',num2str(h(:,2)),'月',num2str(h(:,3)),'日',num2str(h(:,4)),'点',num2str(h(:,5)),'分');
% text2 = '欢迎狗子主人进行实验，多多加油哦'
fid = fopen('text.txt','w');
fprintf(fid,'%s\n',text2);
fclose(fid);
% winopen('text.txt')
if ispc
    sysCommand = 'python bridge.py';
elseif isunix
    sysCommand = 'python3 brdige.py';
else 
    fprintf('Operating system may not be supported, play answer.wav manually'); 
end 
test_mode = 0
if test_mode ~= 1 
    [status, res] = system(sysCommand); 
end 

% 第二步
function pushbutton2_Callback(hObject, eventdata, handles)
I=getappdata(0,'I1');

I=histeq(uint8(I));
% imagesc(I);

imshow(I,'parent',handles.axes2);
% ['subplot(AxesHandle2);image1=histeq(uint8(image1));imagesc(image1);title(text_eq);']);
set(handles.text3,'String','Enhancement by histogram Equalization');
set(handles.text3,'visible','on');
setappdata(0,'I2',I);


% 第三步
function pushbutton3_Callback(hObject, eventdata, handles)
I=getappdata(0,'I2');
% I1= I;
% W=inputdlg(text);W=str2num(char(W));
subplot(handles.axes2);

I=adaptiveThres(double(I),32);
% imshow(I,'parent',handles.axes1);
% imshow(I1,'parent',handles.axes2);

set(handles.text2,'String','Adaptive Binarization after FFT');
set(handles.text2,'visible','on');
setappdata(0,'I3',I);


%第4步
function pushbutton4_Callback(hObject, eventdata, handles)
I=getappdata(0,'I3');
subplot(handles.axes2)

[o1Bound,o1Area]=direction(I,16);
% imshow(I,'parent',handles.axes2);

set(handles.text3,'String','Orientation Flow Estimate');
set(handles.text3,'visible','on');
setappdata(0,'I4',I);
setappdata(0,'o1Bound',o1Bound);
setappdata(0,'o1Area',o1Area);


% 第5步
function pushbutton5_Callback(hObject, eventdata, handles)
I=getappdata(0,'I4');
o1Bound=getappdata(0,'o1Bound');
o1Area=getappdata(0,'o1Area');
subplot(handles.axes2);

[o2,o1Bound,o1Area]=drawROI(I,o1Bound,o1Area);

% imshow(I,'parent',handles.axes1);
set(handles.text2,'String','Orientation Flow Estimate');
set(handles.text2,'visible','on');
% setappdata(0,'I5',o1);
setappdata(0,'o2',o2);
setappdata(0,'o1Bound',o1Bound);
setappdata(0,'o1Area',o1Area);



% 第6步
function pushbutton6_Callback(hObject, eventdata, handles)
% I=getappdata(0,'I5');
o2=getappdata(0,'o2');
subplot(handles.axes2);

o1=im2double(bwmorph(o2,'thin',Inf));
imagesc(o1,[0,1]);

set(handles.text2,'String','Thinned-ridge map');
set(handles.text2,'visible','on');
setappdata(0,'o1',o1);


% 第7步
function pushbutton7_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
subplot(handles.axes2); 

o1=im2double(bwmorph(o1,'clean'));
o1=im2double(bwmorph(o1,'hbreak'));
imagesc(o1,[0,1]);

set(handles.text2,'String','Remove H breaks');
set(handles.text2,'visible','on');
setappdata(0,'o1',o1);


% 第8步
function pushbutton8_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
subplot(handles.axes2);

o1=im2double(bwmorph(o1,'spur'));
imagesc(o1,[0,1]);

set(handles.text2,'String','remove spike');
set(handles.text2,'visible','on');
setappdata(0,'o1',o1);




% 第9步
function pushbutton9_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
o1Bound=getappdata(0,'o1Bound');
o1Area=getappdata(0,'o1Area');
w=getappdata(0,'w');

[end_list1,branch_list1,ridgeMap1,edgeWidth]=mark_minutia(o1,o1Bound,o1Area,w);

subplot(handles.axes2);
show_minutia(o1,end_list1,branch_list1);
set(handles.text2,'String','Minutia');
set(handles.text2,'visible','on');
setappdata(0,'end_list1',end_list1);
setappdata(0,'branch_list1',branch_list1);
setappdata(0,'ridgeMap1',ridgeMap1);
setappdata(0,'edgeWidth',edgeWidth);




% 第10步
function pushbutton10_Callback(hObject, eventdata, handles)
o1=getappdata(0,'o1');
end_list1=getappdata(0,'end_list1');
branch_list1=getappdata(0,'branch_list1');
o1Area=getappdata(0,'o1Area');
ridgeMap1=getappdata(0,'ridgeMap1');
edgeWidth=getappdata(0,'edgeWidth');

[pathMap1,real_end1,real_branch1]=remove_spurious_Minutia(o1,end_list1,branch_list1,o1Area,ridgeMap1,edgeWidth);
subplot(handles.axes1);

show_minutia(o1,real_end1,real_branch1);

set(handles.text2,'String','Remove spurious minutia');
set(handles.text2,'visible','on');
setappdata(0,'real_end1',real_end1);
setappdata(0,'pathMap1',pathMap1);

% 第11步
function pushbutton11_Callback(hObject, eventdata, handles)
real_end1=getappdata(0,'real_end1');
pathMap1=getappdata(0,'pathMap1');
textSaveName='file name';

W=inputdlg(textSaveName);%创建并打开输入对话框 
W=char(W);
% save(W,'real_end1','pathMap1','-ASCII');
save(['C:\Users\瑶瑶\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one\',W,'.dat'],'real_end1','pathMap1','-ASCII');
fprintf('%s',real_end1);