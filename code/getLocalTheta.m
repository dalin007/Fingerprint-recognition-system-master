function [theta,paths1,paths2,paths3] = getLocalTheta(in,start_point,edgeWidth)
paths1 =[];
paths2 =[];
paths3 =[];

			a = start_point;
         pathA = [];
			pathA = a(1,1:2);
         
         theta = [];
         
if a(3) == 0
         for p=1:edgeWidth
            
            [cur,dummy] = size(pathA);
            i = pathA(cur,1);
            j = pathA(cur,2);
                       
            window=in(i-1:i+1,j-1:j+1);
            
            window(2,2) = 0;
            
            if cur > 1
               window( 2 - pathA(cur,1) + pathA(cur-1,1) , 2- pathA(cur,2) + pathA(cur-1,2) ) = 0;
            end;
            
            
            [q,r]=find(window);
            b=[q,r];
            [neighbors,dummy]=size(b);
                                    
            if neighbors == 1
	            pathA(cur+1,1) = b(1,1)-2 + pathA(cur,1);
   	         pathA(cur+1,2) = b(1,2)-2 + pathA(cur,2);
            else
               break;
            end;
          end;
         
	         [path_length, dddd] = size(pathA);			
            paths1 = pathA;
                       
				mean_x = 0;
				mean_y = 0;

			   mean_value = sum(pathA);
            
            mean_x = mean_value(1) / path_length;
				mean_y = mean_value(2) / path_length;

				theta = atan2( (mean_x - pathA(1,1)),(mean_y - pathA(1,2)) );
            
elseif a(3) == 1
   			pathA = [];
   
            total_mx = 0;
            total_my = 0;
            i = a(1);
            j = a(2);
            
            pathA(1,:) = [i,j];
            
            window=in(i-1:i+1,j-1:j+1);
            window(2,2) = 0;
            [q,r]=find(window);
            b=[q,r];
            [neighbors,dummy]=size(b);
            
if neighbors == 3
   for s = 1:3
      
      pathA(2,1) = b(s,1)-2 + pathA(1,1);
		pathA(2,2) = b(s,2)-2 + pathA(1,2);
      
		for p = 1:edgeWidth
            
            [cur,dummy] = size(pathA);
            i = pathA(cur,1);
            j = pathA(cur,2);
            
            window=in(i-1:i+1,j-1:j+1);
            window(2,2) = 0;
            
            if cur > 1
               window( 2 - pathA(cur,1) + pathA(cur-1,1) , 2- pathA(cur,2) + pathA(cur-1,2) ) = 0;
            end;
            
            
            [q,r]=find(window);
            c=[q,r];
            [neighbors,dummy]=size(c);
                                    
            if neighbors == 1
	            pathA(cur+1,1) = c(1,1)-2 + pathA(cur,1);
   	         pathA(cur+1,2) = c(1,2)-2 + pathA(cur,2);
            else
               break;
            end;
    	end;
         
	       [path_length, dddd] = size(pathA);			
                       
	    	mean_x = 0;
			mean_y = 0;

		   mean_value = sum(pathA);
            
         mean_x = mean_value(1) / path_length;
			mean_y = mean_value(2) / path_length;
         
         theta = [theta;atan2( (mean_x - pathA(1,1)),(mean_y - pathA(1,2)) )];
         
         if s == 1
         paths1 = pathA(2:path_length,:);
      	elseif s == 2
      	paths2 = pathA(2:path_length,:);
   		elseif s == 3
      	paths3 = pathA(2:path_length,:);
      	end;
         
         pathA(2:path_length,:) = [];
         
         %total_mx = total_mx + mean_x - pathA(1,1);
         %total_my = total_my + mean_y - pathA(1,2);
         
end;
end;

%com_theta = atan2(total_mx,total_my);

%tmp =abs(theta_b - com_theta);
%theta = min(tmp);
%pathA = path_b(find(tmp==theta));


end;



            
            

