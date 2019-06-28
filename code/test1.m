%matlab语音播报文本的程序
%环境：matlab2014以及以上
%     需要具备python3.0+的编译环境
%time: 2019/5/9
%By:DL 
%文件由三部分组成，text.txt(需要放在同一路径下)
a = "你好"; b = '好'; c = 'name';d = 123;
fid = fopen('text.txt','w');
fprintf(fid,'%s %s %s %d\n',a,b,c,d);
fclose(fid);
winopen('text.txt')
if ispc
    sysCommand = 'python bridge.py';
elseif isunix
    sysCommand = 'python3 brdige.py';
else 
    fprintf('Operating system may not be supported, play answer.wav manually'); 
end 
if test_mode ~= 1 
    [status, res] = system(sysCommand); 
end 
fprintf('For more information, visit: <a href= "http://www.matpic.com">www.matpic.com </a> \n')