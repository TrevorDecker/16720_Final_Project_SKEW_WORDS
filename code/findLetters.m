function [ B ] = findLetters( imagen )
%findLetters returns the top left corner of the letter, the bounding box of each letter, and the letter it was most likely associated with.
%  Inputs: Im - image
%   Outputs: B - nx1 structure where the B.BoundingBox represents bounding box (x,y,w,h),
%               B.Area represents the area of each bounding box
%               B.Centroid represents the centroid of each bounding box
figure; imshow(imagen);

%% Threshold Image into Binary Image
imagen = thresholdImage(imagen);
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
    %pause(0.5)
end

B =propied;
end

