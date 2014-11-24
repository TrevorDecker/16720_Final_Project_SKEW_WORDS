function [ B ] = findLetters( imagen )
%findLetters returns the top left corner of the letter, the bounding box of each letter, and the letter it was most likely associated with.
%  Inputs: Im - image
%   Outputs: B - nx1 structure where
%               B.BoundingBox - bounding box (x,y,w,h) --> to crop image at a given bounding box (image, B(i).BoundingBox)
%               just call imcrop(
%               B.Area - the area of each bounding box
%               B.Centroid - the center of mass of the region within the bounding box (the centroid where things are located)
%               B.Orientation - orientation to make letter upright
figure; imshow(imagen);

%% Threshold Image into Binary Image
imagen = thresholdImage_v2(imagen);
%% Label connected components
[L Ne]=bwlabel(imagen);
%% Measure properties of image regions
propied=regionprops(L,'BoundingBox','Area','Orientation','Centroid');
hold on
%% Plot Bounding Box
% Comment this out to turn off plotting overlay on images
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
pause (1)
%% Objects extraction
% To see each object extraction uncomment this.
%figure
% for n=1:Ne
%     [r,c] = find(L==n);
%     n1=imagen(min(r):max(r),min(c):max(c));
%     %figure;imshow(~n1);
%     %pause(0.5)
% end

B =propied;
end

