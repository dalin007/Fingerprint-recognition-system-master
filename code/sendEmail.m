function sendEmail(subject,content,filePath)
%���ø�ʽΪ��1.sendEmail(subject,content)
%???????????2.sendEmail(subject,content,filePath)
%???Exp1:sendEmail('���MATLAB����ִ���������',strcat('����ִ��������ʱ��Ϊ(s)��',num2str(totalTime)));
%???Exp2:sendEmail('���MATLAB����ִ���������',strcat('����ִ��������ʱ��Ϊ(s)��',num2str(totalTime)),filePath);
%???subject:Ϊ�ʼ�������
%???content��Ϊ�ʼ�������
%???filePath��������·��(Ҫ����������ļ���)
MailAddress='DL_learn@163.com';%�˴���д163�����˺�
password='love2dog';%�˴���д����һ�л�ȡ�Ŀͻ�����Ȩ����
setpref('Internet','E_mail',MailAddress);
setpref('Internet','SMTP_Server','smtp.163.com');
setpref('Internet','SMTP_Username',MailAddress);
setpref('Internet','SMTP_Password',password);
props=java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
if nargin==2
  sendmail(MailAddress,subject,content);
elseif nargin==3
  sendmail(MailAddress,subject,content,filePath);
elseif nargin>3
      error('Too?many?input?arguments');
elseif nargin<2
      error('Too?less?input?arguments');
end
end
% ԭ�ģ�https://blog.csdn.net/guanmaoning/article/details/78942030 
% ��Ȩ����������Ϊ����ԭ�����£�ת���븽�ϲ������ӣ�

