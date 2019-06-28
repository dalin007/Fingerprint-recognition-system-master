vid = videoinput('winvideo',1);
preview(vid);
frame = getsnapshot(vid);
figure;imshow(frame);
% imwrite(frame,'A.png');