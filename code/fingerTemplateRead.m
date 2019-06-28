function template=fingerTemplateRead
[templatefile , pathname]= uigetfile('*.dat','Open An Fingerprint template file'); 
if templatefile ~= 0 
cd(pathname);
template=load(char(templatefile));
end;
