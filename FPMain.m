
clear;
close all; 
clc; 


% Input image
I = imread('leaf.jpg'); 

% Show image
figure(1); imshow(I);

%Place drawing origin relative to robot base frame origin
xOffset = 8; %x offset in [cm] from the robot base frame origin
yOffset = 8; %y offset in [cm] from the robot base frame origin
imDim = 15;  %Set largest size of the image in [cm]

% Get drawing paths boundries and associated coordinates in [cm]
%For leaf.jpg B is a 64 x 1 cell array.  Each of the 64 entries is a path
%to be drawn by the robot
B = imCoordinates(I,yOffset,xOffset,imDim,1); %here argument 1 is the resolution and indicates full resolution.  Higer values give lower resolution

%For each (x,y) value in each path in B calculate the inverse kinematics
%For each array in BT column 1 is theta 1 in radians, column 2 is theta 2
%in radians,column 3 is theta 1 in degrees, column 2 is theta 2 in degrees
BT = invKin(B,15,15); %Arguments 15,15 are the lengths of link 1 and 2 respectively in [cm]



%Plot drawing paths.
for k = 1:length(B)
   boundary = B{k};
   figure(2)
   plot(boundary(:,2), boundary(:,1), 'LineWidth', 3)
   xlim([0 30])
   ylim([-5 30])
   grid on
   hold on
 
end

