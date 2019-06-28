function template=fingerTemplateRead_test
[templatefile , pathname]= uigetfile('C:\Users\ÑþÑþ\Desktop\Fingerprint-recognition-system-master\database\the_first_one\159.dat','Open An Fingerprint template file'); 
% [templatefile , pathname]= 'C:\Users\ÑþÑþ\Desktop\Fingerprint-recognition-system-master\database\the_first_one\159.dat'; 
if templatefile ~= 0 
cd(pathname);
template=load(char(templatefile));
fprintf('pathname:%s\n',pathname)
fprintf('\n templatefile:%s',templatefile)
end;
