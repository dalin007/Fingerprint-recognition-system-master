function [newXY] = MinuOrigin_TransAll(real_end,k)
%  MinuOrigin_all(real_end,k)
%	set the k-th minutia as origin and align its direction to zero(along x)
%  and then accomodate all other minutia points in the fingerprint to the
%  new origin
%
%  Also see MinuOrigin
%  The difference between MinuOrigin and MinuOrigin_all is that the orientation
%  of each minutia is also adjusted with the origin minutia
theta = real_end(k,3);

if theta <0
	theta1=2*pi+theta;
end;

theta1=pi/2-theta;


rotate_mat=[cos(theta1),-sin(theta1),0;sin(theta1),cos(theta1),0;0,0,1];

      toBeTransformedPointSet = real_end';
      
      tonyTrickLength = size(toBeTransformedPointSet,2);
      
      pathStart = real_end(k,:)';
      
      translatedPointSet = toBeTransformedPointSet - pathStart(:,ones(1,tonyTrickLength));
      
      newXY = rotate_mat*translatedPointSet;
      
      %ensure the direction is in the domain[-pi,pi]
      
      for i=1:tonyTrickLength
         if or(newXY(3,i)>pi,newXY(3,i)<-pi)
            newXY(3,i) = 2*pi - sign(newXY(3,i))*newXY(3,i);
         end;
      end;
      
		