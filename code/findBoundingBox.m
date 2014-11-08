function [ B ] = findBoundingBox( I )
%findBoundingBox finds the tightest box around the letters in the image
%   (the boxes from find letters in the function findLetters).  We will rotate
%   the image and keep the orientation of the box with the least amount of area. 
%   Inputs: I - input image
%   Outputs: B - nx1 structure where the B.BoundingBox represents bounding box (x,y,w,h),
%               B.Area represents the area of each bounding box
%               B.Centroid represents the centroid of each bounding box

% Rotate each portion of the image contained within the bounding box by a
% degree.  We will keep the bounding box which creates the smallest amount
% of area and store its area, orientation, and location.

%%TODO: test and remove whitespace rows and columns.  
%%WORK IN PROGRESS-- DO NOT USE

% Get Bounding Box Data from findLetters
X = findLetters(I);

% Extract the portion of the image within the bounding box
for n=1:size(X.BoundingBox,1)
    [r,c] = find(L==n);
    n1=imagen(min(r):max(r),min(c):max(c));

    % Find the best rotation to minimize area.
    for i=1:360
        % rotate the image 
        rn1 = imrotate(n1,i);
        % remove whitespace from the image (zero rows and zero columns)
        %   and keep track of which cols and rows you removed by keeping
        %   track of the new x,y index of the top left corner.
        
        

        % get the new area, if it's smaller, then we replace the location,
        % and area.
        area = size(rn1,1)*size(rn1,2);
        if (area < X(n).Area)
            X(n).Area = area;
            X(n).BoundingBox = [nx,ny,size(rn1,1),size(rn1,2)];
            X(n).Orientation = i;
        end
    end
    %figure;imshow(~n1);
    pause(0.5)
end


end

