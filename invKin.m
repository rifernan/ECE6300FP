function [BTheta] = invKin(B,L1,L2);
%Returns a cell array BTheta containing the joint space for cartesian 
% cordinates given in cell array B.  L1 is the length of link 1; L2 is the
% length of link 2
BTheta = B;
%Compute inverse kinamatics for each path in Cell array B
for k = 1:length(BTheta)
   b = BTheta{k};
   
   for j = 1:length(b)
   %Take cartesian coordinates for each pint in path    
   x=b(j,2);
   y=b(j,1);
   
   %Use law of cosines to compute Cos(theta 2)
   D= (x^2+y^2-L1^2-L2^2)/(2*L1*L2);
   %Compute Theat2
   Theta2=atan2(sqrt(1-D^2),D);
    %Compute Theat1
    Theta1=atan2(y,x)-atan2(L2*sin(Theta2),L1+L2*cos(Theta2));
    %Store Theat 1 in column1
    b(j,1)=Theta1;
    %Store Theat 2 in column2
    b(j,2)=Theta2;
    
    %Convert Theta 1 and 2 to degrees
    Theta1d=Theta1*(180/pi);
    Theta2d=Theta2*(180/pi);
    %Store Theat 1 in degrees in column3
    b(j,3)=Theta1d;
    %Store Theat 2 in degrees in column4
    b(j,4)=Theta2d;
   
   end
   BTheta{k} = b;
end

