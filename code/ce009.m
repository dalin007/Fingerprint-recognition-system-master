finger1=fingerTemplateRead;
maindir = 'C:\Users\����\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one';
subdir  = dir( maindir );
max_percent = 0;
flag=0;
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' )||...%isequal���������Ƿ���ȣ���ȷ���1��
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % �������Ŀ¼������
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, '*.dat' );
    dat = dir( subdirpath )               % ���ļ������Һ�׺Ϊdat���ļ�

    for j = 1 : length( dat )
        datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
        fid = fopen( datpath );
        % �˴������Ķ��ļ���д���� %
    end
    finger2=load(char('subdir2.name'))
    for j = 1 : length( subdir )
      finger(j+1)=load(char('subdir( j ).name'));
      percent_match(j)=match_end(finger1,finger(j+1),10);
        if percent_match(j) >= max_percent
             max_percent = percent_match(j);
             flag = 'subdir( j ).name'
        else
             max_percent = max_percent;
        end
    end
end

text2 = strcat('�������ˣ����������ݿ�ָ�Ʊȶԣ�����ƥ�����Ϊ�ٷ�֮',num2str(max_percent),'������',flag);
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

