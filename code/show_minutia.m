function show_minutia(image,end_list,branch_list);
colormap(gray);imagesc(image);
hold on;

if ~isempty(end_list)

plot(end_list(:,2),end_list(:,1),'*r');
if size(end_list,2) == 3
   hold on
	[u,v] = pol2cart(end_list(:,3),10);
	quiver(end_list(:,2),end_list(:,1),u,v,0,'g');
end;
end;

if ~isempty(branch_list)
hold on
plot(branch_list(:,2),branch_list(:,1),'+y');
end;



	
