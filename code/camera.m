% function camera
% 100个正常的 & 100个戴眼镜的 & 100个戴帽子的 & 100个眼镜+帽子的 & 100个杂物的
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