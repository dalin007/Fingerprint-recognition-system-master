function [newXY] = MinuOriginTransRidge(real_end,k,ridgeMap)
%  MinuOrigin(real_end,k,ridgeMap)
%	set the k-th minutia as origin and align its direction to zero(along x)
%  and then accomodate all other ridge points connecting to the miniutia to the
%  new coordinaete system
%
%  Note that the coordination sytem and the angle are different:
%  ---------------------->y
%  |\
%  | \
%  |  \
%  |   \   
%  |thet\a
%  x
%  position value toward bottom, right are positive.
%  angle value are anti-clockwised from bottom to the top of the x axis on the right,within [0,pi]
%          and are clockwised from bottom to top of the x axis on the left,within [0,-pi]
	
		%construct the affine transform matrix	
		% cos(theta)  -sin(theta)
		% sin(theta)   cos(thea)
		% to rotate angle theta
      
      theta = real_end(k,3);
      if theta <0
		theta1=2*pi+theta;
		end;

		theta1=pi/2-theta;

      rotate_mat=[cos(theta1),-sin(theta1);sin(theta1),cos(theta1)];
      
      %locate all the ridge points connecting to the miniutia
      %and transpose it as the form:
      %x1 x2 x3...
      %y1 y2 y3...
      pathPointForK = find(ridgeMap(:,3)== k);
      toBeTransformedPointSet = ridgeMap(min(pathPointForK):max(pathPointForK),1:2)';
      
      %translate the minutia position (x,y) to (0,0)
      %translate all other ridge points according to the basis 
      tonyTrickLength = size(toBeTransformedPointSet,2);
      pathStart = real_end(k,1:2)';
      translatedPointSet = toBeTransformedPointSet - pathStart(:,ones(1,tonyTrickLength));
      
      %rotate the point sets 
      newXY = rotate_mat*translatedPointSet;
      
     
            
      
      
