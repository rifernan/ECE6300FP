clc
clear
 
%Setup
%Define Arduino
a = arduino('COM3','Uno','Libraries','Servo');

%Define and initialize servos
s1 = servo(a,'D4')

writePosition(s1, 0.5);
pause(2);
s2 = servo(a,'D5')

writePosition(s2, 0.5);
pause(2);

%create x y cordinates for a line
x=[15:.01:20]; 
x=x';
y=15*ones(501,1);

%Place coordinates in cell array B
b1=[y,x];
B{1}=b1;

%Get joint angles for coordinates
BT = invKin(B,10.3,19);

%Convert joint angles to servo signals
BS=servoSig(BT);

%Send servo signals to servos
bs=BS{1};
bs1=bs(:,1:2)

 for k = 1:length(bs1)
     
writePosition(s1,bs1(k,1))

writePosition(s2,bs1(k,2))

 
 end
 
 clear
 