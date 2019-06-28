finger1=fingerTemplateRead;
maindir = 'C:\Users\瑶瑶\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one';
subdir  = dir( maindir );
max_percent = 0;
flag=0;
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' )||...%isequal输入数组是否相等，相等返回1；
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % 如果不是目录则跳过
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, '*.dat' );
    dat = dir( subdirpath )               % 子文件夹下找后缀为dat的文件

    for j = 1 : length( dat )
        datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
        fid = fopen( datpath );
        % 此处添加你的对文件读写操作 %
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

text2 = strcat('狗子主人，经过与数据库指纹比对，最大的匹配概率为百分之',num2str(max_percent),'可能是',flag);
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

