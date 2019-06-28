% function camera
% 100�������� & 100�����۾��� & 100����ñ�ӵ� & 100���۾�+ñ�ӵ� & 100�������
vid = videoinput('winvideo',1, 'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
preview(vid);
tic;
i = 1;
while 1
    frame = getsnapshot(vid);
    imshow(frame);
    imwrite(frame,strcat(num2str(i),'.jpg'),'jpg');
    i = i+1;
    if i >= 101
        break;
    end
end
toc;