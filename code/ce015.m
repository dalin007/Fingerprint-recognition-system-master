vid = videoinput('winvideo',1);
preview(vid);
set(vid,'ReturnedColorSpace','rgb');
frame = getsnapshot(vid);
figure;imshow(frame);
writerObj = VideoWriter( [filename '.avi'] );
writerObj.FrameRate = N;
open(writerObj);
figure;
for ii = 1: nframe
    frame = getsnapshot(vid);
    imshow(frame);
    f.cdata = frame;
    f.colormap = [];
    writeVideo(writerObj,f);
end
close(writerObj);