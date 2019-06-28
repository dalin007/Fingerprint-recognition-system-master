% function CreatVideoFromPic(dn, picformat,aviname)

% CreatVideoFromPic( 'picture_for_video', 'jpg','video\JK.avi')
dn =  'E:\Desktop\Fingerprint-recognition-system-master\code\picture_for_video';
picformat = 'jpg';
aviname = 'E:\Desktop\Fingerprint-recognition-system-master\code\Email\video\JK.avi'

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

