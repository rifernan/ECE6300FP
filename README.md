# ECE6300FP
Final Project for ECE6300
FPMain.m is the main MATLAB script for the final project. The following data files and functions are called in this script.
Image file leaf.jpg is uploaded by FPMain.m.  
imCoordinates.m is a MATLAB function that computes the image paths and associated coordinates.  
invKin.m is a MATLAB function that computes the angles theta 1 and theta 2 for the paths coordinates found by imCoordinates.m

11/18 RIF
Added servoSig.m a MATLAB function that converts the joint values found by invKin.m to servo command signals. 
Updated invKin.m to give correct value for theta 1
Added Test_Draw_Line.m a MATLAB script to test how the system draws a line.
