function [BServo] = servoSig(BTheta);
BServo = BTheta;
for k = 1:length(BTheta)
   b = BTheta{k};
   
   for j = 1:length(b)
   r1 = b(j,1);
   r2 = b(j,2);
   
   s1 = r1*(1/pi);
   s2 = r2*(1/pi);
  
    b(j,1)=s1;
    b(j,2)=s2;
   
   end
   BServo{k} = b;

end