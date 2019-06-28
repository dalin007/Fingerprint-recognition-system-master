finger1=fingerTemplateRead;

% maindir = 'D:\MATLAB\project';
% subdir  = dir( maindir );
% 
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' )||...
%         isequal( subdir( i ).name, '..')||...
%         ~subdir( i ).isdir)               % 如果不是目录则跳过
%         continue;
%     end
%     subdirpath = fullfile( maindir, subdir( i ).name, '*.dat' );
%     dat = dir( subdirpath )               % 子文件夹下找后缀为dat的文件
% 
%     for j = 1 : length( dat )
%         datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
%         fid = fopen( datpath );
%         % 此处添加你的对文件读写操作 %
%     end
% end
subdirpath = fullfile('C','Users','瑶瑶','Desktop','Fingerprint-recognition-system-master','code','database','the_first_one','*.dat');
dat = dir( subdirpath ) 
max_percent = 0;
flag=0;
disp(dat.name)

fprintf('%d\n', dat.date );
for i = 1 : length( dat )
    
    finger(i+1)=load(char('i.dat'));
    percent_match(i)=match_end(finger1,finger(i+1),10);
    if percent_match(i) >= max_percent
         max_percent = percent_match(i);
         flag = 'i'
    else
         max_percent = max_percent;
    end
end
% maindir = 'D:\MATLAB\project';
% subdir  = dir( maindir );
% 
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' )||...
%         isequal( subdir( i ).name, '..')||...
%         ~subdir( i ).isdir)               % 如果不是目录则跳过
%         continue;
%     end
%     subdirpath = fullfile( maindir, subdir( i ).name, '*.dat' );
%     dat = dir( subdirpath )               % 子文件夹下找后缀为dat的文件
% 
%     for j = 1 : length( dat )
%         datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
%         fid = fopen( datpath );
%         % 此处添加你的对文件读写操作 %
%     end
% end
% subdirpath = fullfile('C','Users','瑶瑶','Desktop','Fingerprint-recognition-system-master','code','database','the_first_one','*.dat');
% dat = dir( subdirpath ) 
% max_percent = 0;
% flag=0;
% length( dat )
% for i = 1 : length( dat )
%     
%     finger(i+1)=load(char('i.dat'));
%     percent_match(i)=match_end(finger1,finger(i+1),10);
%     if percent_match(i) >= max_percent
%          max_percent = percent_match(i);
%          flag = 'i'
%     else
%          max_percent = max_percent;
%     end
% end

% cd('C:\Users\瑶瑶\Desktop\Fingerprint-recognition-system-master\code\database\the_first_one\');
% finger2=load(char('1th.dat'));
% finger3=load(char('2th.dat'));
% finger4=load(char('3th.dat'));
% 
% percent_match1=match_end(finger1,finger2,10);
% percent_match2=match_end(finger1,finger3,10);
% percent_match3=match_end(finger1,finger4,10);
% 
% max_percent = 0;
% if percent_match1 >= max_percent
%     max_percent = percent_match1;
%     flag = '1th'
% else
%     max_percent = max_percent;
% end
% if percent_match2 >= max_percent
%      max_percent = percent_match2;
%      flag = '2th'
% else
%     max_percent = max_percent;
% end
% 
% if percent_match3 >= max_percent
%      max_percent = percent_match3;
%      flag = '3th'
% else
%     max_percent = max_percent;
% end