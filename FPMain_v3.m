%% Robotics Drawbot Team - Fall 2021
% Raymond Fernandez, Collin Rogers, Leon Butler

clear;
close all; 
clc; 

fprintf("Drawbot Initializing...\n")
% Input image
I = imread('leaf.jpg'); 

% Show image
figure(1); imshow(I);

%Place drawing origin relative to robot base frame origin
xOffset = -15; %x offset in [cm] from the robot base frame origin
yOffset = 10; %y offset in [cm] from the robot base frame origin
imDim = 18;  %Set largest size of the image in [cm]

% Get drawing paths boundries and associated coordinates in [cm]
B = imCoordinates(I,yOffset,xOffset,imDim,1); 


%For each (x,y) value in each path in B calculate the inverse kinematics
%For each array in BT column 1 is theta 1 in radians, column 2 is theta 2
%in radians,column 3 is theta 1 in degrees, column 2 is theta 2 in degrees
BT = invKin(B,10.47,20); 




%Plot drawing paths.
fprintf("\nPre-plotting Image\n")
pctp = 0;
p = 5; % Percentage Tracker Interval
for k = 1:length(B)
   boundary = B{k};
   figure(2)
   plot(boundary(:,2), boundary(:,1), 'LineWidth', 3)
   xlim([0 30])
   ylim([-5 30])
   grid on
   hold on
   pct = round(k / length(B) * 100);
   if (pct >= pctp + p) % Shows percentage of progress
       fprintf("Plotting: %d%%\n",pct);
       pctp = pct;
   end
end

%Define Arduino
a = arduino('COM3','Uno','Libraries','Servo');
fprintf("\nArduino Activated");
offset2 = -.05;

%Define and initialize servos
s1 = servo(a,'D3');
writePosition(s1, .5);
pause(1);
s2 = servo(a,'D4');
writePosition(s2, .5);
pause(1);
s3 = servo(a,'D5');
writePosition(s3, .0);
pause(1);
fprintf("\nServos Ready");

% Angles given to Motors
fprintf("\nSending Code to Arduino\n")
pctp = 0;
for i = 1:height(BT) % This steps through each major division
    BTArray = cell2mat(BT(i));
    for j = 1:height(BTArray) % The points for each division
        
        t1 = (BTArray(j,3))/180; % Added 90 because Servo code doesn't like negatives?
        t2 = BTArray(j,4)/180; % Gives angle from 0-1 
        if (t1<(1/180))
            t1 = 1/180;
        end
        if (t2>(145/180))
            t2 = 145/180;
        end
        writePosition(s1, t1); % Sends angle to Motor 1 
        writePosition(s2, t2);
        if(j==1)
            pause(.01);
            writePosition(s3, .0);
            pause(1);
        end
    end

    if(1)
        writePosition(s3, .12);
        pause(1);
    end

    pct = round(i / height(BT) * 100);
    if (pct >= pctp + p) % Shows percentage of progress
       fprintf("Drawing: %d%%\n",pct);
       pctp = pct;
    end
end
writePosition(s1, .5);
writePosition(s2, .5);

clear s1 s2 s3 a;

fprintf("\nDone.\n")

