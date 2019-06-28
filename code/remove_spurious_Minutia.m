function [pathMap, final_end,final_branch] =remove_spurious_Minutia(in,end_list,branch_list,inArea,ridgeOrderMap,edgeWidth)

[w,h] = size(in);

final_end = [];
final_branch =[];
direct = [];
pathMap = [];

end_list(:,3) = 0;
branch_list(:,3) = 1;

minutiaeList = [end_list;branch_list];
finalList = minutiaeList;
[numberOfMinutia,dummy] = size(minutiaeList);
suspectMinList = [];
for i= 1:numberOfMinutia-1
   for j = i+1:numberOfMinutia
      d =( (minutiaeList(i,1) - minutiaeList(j,1))^2 + (minutiaeList(i,2)-minutiaeList(j,2))^2)^0.5;
      
      if d < edgeWidth
         suspectMinList =[suspectMinList;[i,j]];
      end;
   end;
end;
[totalSuspectMin,dummy] = size(suspectMinList);
%totalSuspectMin
for k = 1:totalSuspectMin
   typesum = minutiaeList(suspectMinList(k,1),3) + minutiaeList(suspectMinList(k,2),3);
   
   if typesum == 1
      % branch - end pair
      if ridgeOrderMap(minutiaeList(suspectMinList(k,1),1),minutiaeList(suspectMinList(k,1),2) ) ==  ridgeOrderMap(minutiaeList(suspectMinList(k,2),1),minutiaeList(suspectMinList(k,2),2) )
         finalList(suspectMinList(k,1),1:2) = [-1,-1];
	      finalList(suspectMinList(k,2),1:2) = [-1,-1];
      end;
      
   elseif typesum == 2
      % branch - branch pair
      if ridgeOrderMap(minutiaeList(suspectMinList(k,1),1),minutiaeList(suspectMinList(k,1),2) ) ==  ridgeOrderMap(minutiaeList(suspectMinList(k,2),1),minutiaeList(suspectMinList(k,2),2) )
         finalList(suspectMinList(k,1),1:2) = [-1,-1];
	      finalList(suspectMinList(k,2),1:2) = [-1,-1];
      end;
      
   elseif typesum == 0
      % end - end pair
      a = minutiaeList(suspectMinList(k,1),1:3);
      b = minutiaeList(suspectMinList(k,2),1:3);
      
      if ridgeOrderMap(a(1),a(2)) ~=  ridgeOrderMap(b(1),b(2))
         
         [thetaA,pathA,dd,mm] = getLocalTheta(in,a,edgeWidth); 
         [thetaB,pathB,dd,mm] = getLocalTheta(in,b,edgeWidth); 
         
         %the connected line between the two points
         
         thetaC = atan2( (pathA(1,1)-pathB(1,1)), (pathA(1,2) - pathB(1,2)) );
         
         
         angleAB = abs(thetaA-thetaB);
         angleAC = abs(thetaA-thetaC);
         

         if ( (or(angleAB < pi/3, abs(angleAB -pi)<pi/3 )) & (or(angleAC < pi/3, abs(angleAC - pi) < pi/3)) )  
            finalList(suspectMinList(k,1),1:2) = [-1,-1];
            finalList(suspectMinList(k,2),1:2) = [-1,-1];
         end;
         
         %remove short ridge later
      elseif  ridgeOrderMap(a(1),a(2)) ==  ridgeOrderMap(b(1),b(2))        
         finalList(suspectMinList(k,1),1:2) = [-1,-1];
         finalList(suspectMinList(k,2),1:2) = [-1,-1];

      end;
   end;
end;

   for k =1:numberOfMinutia
      if finalList(k,1:2) ~= [-1,-1]
         if finalList(k,3) == 0
            [thetak,pathk,dd,mm] = getLocalTheta(in,finalList(k,:),edgeWidth);
            if size(pathk,1) >= edgeWidth
            	final_end=[final_end;[finalList(k,1:2),thetak]];
            	[id,dummy] = size(final_end);
            	pathk(:,3) = id;
            	pathMap = [pathMap;pathk];
            end;
         else
            
            final_branch=[final_branch;finalList(k,1:2)];
            
            [thetak,path1,path2,path3] = getLocalTheta(in,finalList(k,:),edgeWidth);
            
            if size(path1,1)>=edgeWidth & size(path2,1)>=edgeWidth & size(path3,1)>=edgeWidth
               
            final_end=[final_end;[path1(1,1:2),thetak(1)]];
            [id,dummy] = size(final_end);
            path1(:,3) = id;
            pathMap = [pathMap;path1];
           
            final_end=[final_end;[path2(1,1:2),thetak(2)]];
            path2(:,3) = id+1;
            pathMap = [pathMap;path2];
           

            final_end=[final_end;[path3(1,1:2),thetak(3)]];
				path3(:,3) = id+2;
            pathMap = [pathMap;path3];
           
         	end;
         
            
         end;
      end;
   end;
   
   %final_end
   %pathMap
   %edgeWidth      
  
       
         
