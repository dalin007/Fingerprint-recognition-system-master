%matlab���������ı��ĳ���
%������matlab2014�Լ�����
%     ��Ҫ�߱�python3.0+�ı��뻷��
%time: 2019/5/9
%By:DL 
%�ļ�����������ɣ�text.txt(��Ҫ����ͬһ·����)
a = "���"; b = '��'; c = 'name';d = 123;
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