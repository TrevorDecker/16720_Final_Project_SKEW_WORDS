function [ B ] = findLetters( imagen )
%findLetters returns the top left corner of the letter, the bounding box of each letter, and the letter it was most likely associated with.
%  Inputs: Im - image
%   Outputs: B - nx1 structure where the B.BoundingBox represents bounding box (x,y,w,h),
%               B.Area represents the area of each bounding box
%               B.Centroid represents the centroid of each bounding box
figure; imshow(imagen);

%% TODO: Segment image based on gradient or based on cells or both (improve segmentation)
%% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
%% Convert to binary image
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
%% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
pause(1)
%% Show image binary image
figure(2)
imshow(~imagen);
title('INPUT IMAGE WITHOUT NOISE')
%% Label connected components
[L Ne]=bwlabel(imagen);
%% Measure properties of image regions
propied=regionprops(L,'BoundingBox','Area','Orientation','Centroid');
hold on
%% Plot Bounding Box
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
pause (1)
%% Objects extraction
%figure
for n=1:Ne
    [r,c] = find(L==n);
    n1=imagen(min(r):max(r),min(c):max(c));
    %figure;imshow(~n1);
    pause(0.5)
end

B =propied;
end
