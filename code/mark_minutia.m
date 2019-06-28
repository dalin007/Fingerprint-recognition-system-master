function [end_list,branch_list,ridgeOrderMap,edgeWidth] = mark_minutia(in, inBound,inArea,block);
[w,h] = size(in);

[ridgeOrderMap,totalRidgeNum] = bwlabel(in); 

imageBound = inBound;
imageArea = inArea;
blkSize = block;

%innerArea = im2double(inArea)-im2double(inBound);


edgeWidth = interRidgeWidth(in,inArea,blkSize);

end_list    = [];
branch_list = [];


for n=1:totalRidgeNum
   [m,n] = find(ridgeOrderMap==n);
   b = [m,n];
   ridgeW = size(b,1);
   for x = 1:ridgeW
      i = b(x,1);
      j = b(x,2);
if inArea(ceil(i/blkSize),ceil(j/blkSize)) == 1          
      neiborNum = 0;
      neiborNum = sum(sum(in(i-1:i+1,j-1:j+1)));
      neiborNum = neiborNum -1;       
   if neiborNum == 1 
		end_list =[end_list; [i,j]];           
   elseif neiborNum == 3
      tmp=in(i-1:i+1,j-1:j+1);      
      tmp(2,2)=0;
      [abr,bbr]=find(tmp==1);
      t=[abr,bbr];      
      if isempty(branch_list)
         branch_list = [branch_list;[i,j]];
      else            
      for p=1:3
         cbr=find(branch_list(:,1)==(abr(p)-2+i) & branch_list(:,2)==(bbr(p)-2+j) );
         if ~isempty(cbr)
            p=4;
            break;
         end;
      end;
      if p==3
         branch_list = [branch_list;[i,j]];
      end;
   	end;
  	end;	
	end;
end;
end;
