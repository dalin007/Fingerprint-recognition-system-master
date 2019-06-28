%script file for batched enrolling fingerprints
t = cputime;
for i=101:104
   for j=1:3
      i
      j
   fname = sprintf('d:\\419\\image\\%d_%d.tif',i,j);
      
   o1 = imread(fname);
   o1 =255 - double(o1);
   o1=histeq(uint8(o1));
   o1=fftenhance(o1,0.45);
   
   o1=adaptiveThres(double(o1),32,0);
   [o1Bound,o1Area]=direction(o1,16,0);
   [o1,o1Bound,o1Area]=drawROI(o1,o1Bound,o1Area,0);
   
   o1=im2double(bwmorph(o1,'thin',Inf));
   o1=im2double(bwmorph(o1,'clean'));
   o1=im2double(bwmorph(o1,'hbreak'));
   o1=im2double(bwmorph(o1,'spur'));
   
   [end_list1,branch_list1,ridgeMap1,edgeWidth]=mark_minutia(o1,o1Bound,o1Area,16);
   [pathMap1,real_end1,real_branch1]=remove_spurious_Minutia(o1,end_list1,branch_list1,o1Area,ridgeMap1,edgeWidth);
   fname2=sprintf('%s.dat',fname);
   save(fname2,'real_end1','pathMap1','-ASCII');
   end;
end;
t2=cputime;
t2-t
   
