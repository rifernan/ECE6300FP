function [B] = imCoordinates(I,yOffset,xOffset,imWidth, res);
% Returs B a cell array containing the cartesian coordinates in [cm] for paths
% found in image I.  YOffset,and xOffset are the catesian offset values
% given in [cm] from the robot's origin.  ImWidth is the image width in
% [cm] used to convert pixles to [cm] (a square image is expected).  Res is
% the number of way pionts to keep .  For example setting res to 5 would
% keep every 5th way point.
%Get length of largest array dimension
imLen = length(I);
I=flipud(I);

%Find edges in grayscale image using Canny method and specified thresholds
[BW,thre] = edge(rgb2gray(I),'Canny',[0.0813 0.1281]); 

%Get the image skeleton
BW2 = bwmorph(BW,'skel',Inf);
	
%Remove spur pixels from image skeleton
BW3 = bwmorph(BW2,'spur',3);
	
%Find branch points of image skeleton
branchPoints = bwmorph(BW3,'branch',1);

%Dilate branch locations with a disk-shaped structuring  
branchPoints = imdilate(branchPoints,strel('disk',1));

%Remove branch points 
BW3 = BW3 & ~branchPoints;

%Removes all connected components (objects) that have fewer than P pixels
BWseg = bwareaopen(BW3,10);

%Trace region boundaries in binary image do not include the boundaries of holes inside other objects.
[B,L] = bwboundaries(BWseg,'noholes');

%Extract a path from the boundary
for i = 1:length(B)
    boundary = B{i};
    edgeind = find(all(circshift(boundary,1)==circshift(boundary,-1),2),1);

    if ~isempty(edgeind)
        boundary = circshift(boundary,-edgeind+1);
        boundary = boundary(1:ceil(end/2),:);
    end
    B{i} = boundary;
end

%Convert pixle indicies to [cm] with x,y origin offsets using resolution of res

for k = 1:length(B)
   b = B{k};
   i=1;
   for j = 1:res:length(b)
       bLR(i,1)= (b(j,1)*(imWidth/imLen))+yOffset;  
       bLR(i,2)= (b(j,2)*(imWidth/imLen))+xOffset;  
       i=i+1;  
   end
   
   B{k}=bLR;
   clear bLR
end









