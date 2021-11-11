function [BTheta] = invKin(B,L1,L2);
BTheta = B;
for k = 1:length(BTheta)
   b = BTheta{k};
   
   for j = 1:length(b)
   x=b(j,2);
   y=b(j,1);
   
   D= (x^2+y^2-L1^2-L2^2)/(2*L1*L2);
   Theta2=atan2(sqrt(1-D^2),D);
   Theta1=atan2(y,x)-atan2(L2*sin(Theta2),L1+L2*cos(Theta2));
    b(j,1)=Theta1;
    b(j,2)=Theta2;
    
    Theta1d=Theta1*(180/pi);
    Theta2d=Theta2*(180/pi);
    b(j,3)=Theta1d;
    b(j,4)=Theta2d;
   
   end
   BTheta{k} = b;
end


