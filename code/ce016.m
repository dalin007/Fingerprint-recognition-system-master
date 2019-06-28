clear all; clc
closepreview
vid = videoinput('winvideo',1,'YUY2_640x480');
preview(vid)£»
filename = 'film';
nframe = 120;       
nrate = 30;
MakeVideo(vid, filename, nframe, nrate, 1)