clear
FigWin = figure('Position',[50 -50 650 500],...
   'Name','Fingerprint Recognition System',...
   'NumberTitle','off',...
   'Color',[ 0.827450980392157 0.815686274509804 0.776470588235294 ]);

AxesHandle1 = axes('Position',[0.2 0.15 0.35 0.7],...
   'Box','on');
AxesHandle2 = axes('Position',[0.6 0.15 0.35 0.7],...
   'Box','on');

BackColor = get(gcf,'Color');

FrameBox = uicontrol(FigWin,...
   'Units','normalized', ...
   'Style','frame',...
   'BackgroundColor',[ 0.741176470588235 0.725490196078431 0.658823529411765 ],...
   'ForegroundColor',[ 0.741176470588235 0.725490196078431 0.658823529411765 ],...
	'Position',[0 0 0.15 1]);

%create static text.
%
Text2 = uicontrol(FigWin,...
   'Style','text',...
   'Units','normalized', ...
   'Position',[0 0.95 1 0.05],...
   'FontSize',15,...
   'BackgroundColor',[ 0.741176470588235 0.725490196078431 0.658823529411765 ],...
   'HorizontalAlignment','right', ...
   'String','Fingerprint Recognition System');


Text2 = uicontrol(FigWin,...
   'Style','text',...
   'Units','normalized', ...
   'Position',[0 0 1 0.05],...
   'FontSize',15,...
   'BackgroundColor',[ 0.741176470588235 0.725490196078431 0.658823529411765 ],...
   'HorizontalAlignment','right', ...
   'String','');

%第一步
w=16;
textLoad='Load Fingerprint Image';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
   'Position',[0,300,80,20],...
   'String','Load',...
   'Callback',...
   ['image1=loadimage;'...
    'subplot(AxesHandle1);'...
    'imagesc(image1);'...
    'title(textLoad);'...
	 'colormap(gray);']);

%第二步
text_eq='Enhancement by histogram Equalization';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
   'Position',[0,280,80,20],...
   'String','his-Equalization',...
   'Callback',...
   ['subplot(AxesHandle2);image1=histeq(uint8(image1));imagesc(image1);title(text_eq);']);
%第三步
text21='Adaptive Binarization after FFT';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
   'Position',[0,260,80,20],...
   'String','Binarization',...
   'Callback',...
   [%'W=inputdlg(text);W=str2num(char(W));'...
      'subplot(AxesHandle1);'...
      'image1=adaptiveThres(double(image1),32);title(text21);']);
  %第四步
text_filterArea='Orientation Flow Estimate';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
	'Position',[0,240,80,20],...   
	'String','Direction',...
	'Callback',...
   ['subplot(AxesHandle2);[o1Bound,o1Area]=direction(image1,16);title(text_filterArea);']);

%第五步
text_ROI='Region Of Interest(ROI)';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
	'Position',[0,220,80,20],...   
	'String','ROI Area',...
	'Callback',...
   ['subplot(AxesHandle2);[o2,o1Bound,o1Area]=drawROI(image1,o1Bound,o1Area);title(text_ROI);']);
%第六步 
text31='Thinned-ridge map';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
   'Position',[0,200,80,20],...
   'String','Thining',...
   'Callback',...
   ['subplot(AxesHandle2);o1=im2double(bwmorph(o2,''thin'',Inf));imagesc(o1,[0,1]);title(text31);']);

%第七步
text41='Remove H breaks';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
   'Position',[0,180,80,20],...
   'String','remove H breaks',...
	'Callback',...
   ['subplot(AxesHandle2);o1=im2double(bwmorph(o1,''clean''));o1=im2double(bwmorph(o1,''hbreak''));imagesc(o1,[0,1]);title(text41);']);

%第八步
textn1='remove spike';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
   'Position',[0,160,80,20],...
   'String','Removing spike',...
   'Callback',...
   ['subplot(AxesHandle2);o1=im2double(bwmorph(o1,''spur''));imagesc(o1,[0,1]);title(textn1);']);
%第九步
%% locate minutia and show all those minutia
text51='Minutia';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
	'Position',[0,140,80,20],...   
	'String','Extract',...
	'Callback',...
   ['[end_list1,branch_list1,ridgeMap1,edgeWidth]=mark_minutia(o1,o1Bound,o1Area,w);'...
	'subplot(AxesHandle2);show_minutia(o1,end_list1,branch_list1);title(text51);']);
%第十步
%Process for removing spurious minutia
text61='Remove spurious minutia';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
	'Position',[0,120,80,20],...
	'String','Real Minutiae',...
   'Callback',...
   ['[pathMap1,real_end1,real_branch1]=remove_spurious_Minutia(o1,end_list1,branch_list1,o1Area,ridgeMap1,edgeWidth);'...
   'subplot(AxesHandle1);show_minutia(o1,real_end1,real_branch1);title(text61);']);
%第十一步
%save template file, including the minutia position,direction,and ridge information
textSaveName='file name';
h=uicontrol(FigWin,...
   'Style','pushbutton',...
	'Position',[0,100,80,20],...
	'String','save',...
   'Callback',...
   ['W=inputdlg(textSaveName);W=char(W);'...
    'save(W,''real_end1'',''pathMap1'',''-ASCII'');']);
%第十二步
%invoke template file loader and do matching
h=uicontrol('Style','pushbutton',...
   'String','Match',...
	'Position',[0,80,80,20],...
	'Callback',...
   ['finger1=fingerTemplateRead;'...
    'finger2=fingerTemplateRead;'...
    'percent_match=match_end(finger1,finger2,10);']);
