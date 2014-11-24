function [ final ] = thresholdImage_v2( I )
%thresholdImage to see the desired features more clearly
%   Inputs: I - image
%   Outputs: final - binary thresholded image
%% Convert to gray scale
%if size(imagen,3)==3 %RGB image
%    imagen=rgb2gray(imagen);
%end
% Convert to binary image
%threshold = graythresh(imagen);
%imagen =~im2bw(imagen,threshold);
% Remove all object containing fewer than 30 pixels
%imagen = bwareaopen(imagen,30);
%pause(1)
% Show image binary image
%figure(2)
%imshow(~imagen);
%title('INPUT IMAGE WITHOUT NOISE')

img = rgb2gray(I); %to make it grayscale
% figure('Name','Original Grayscale');imshow(img);

final = img;

%% Perform edge detection
edgeMask = edge(final);

%% rem < 30 pixels 
% final = bwareaopen(final,30);
% pause(0.5);
% figure('Name','rem < 30 pixels');imshow(final);

%% Special sobel
sobelMask = conv2(double(img), fspecial('sobel'), 'same');

%% MSER regions
% Detect and extract regions
mserRegions = detectMSERFeatures(img,'RegionAreaRange',[150 2000]);
mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList));  % extract regions

% % Visualize the MSER regions overlaid on the original image
% figure; imshow(I); hold on;
% plot(mserRegions, 'showPixelList', true,'showEllipses',false);
% title('MSER regions');

% Convert MSER pixel lists to a binary mask
mserMask = false(size(img));
ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
mserMask(ind) = true;

%% Show each pair
MS = mserMask & sobelMask;

ES = edgeMask & sobelMask;

ME = mserMask & edgeMask;

figure; hold on;
subplot(1,6,1), subimage(mserMask), title('MSER regions')
subplot(1,6,2), subimage(edgeMask), title('Edges')
subplot(1,6,3), subimage(sobelMask), title('Sobel regions')
subplot(1,6,4), subimage(MS), title('MSER regions and Sobel regions')
subplot(1,6,5), subimage(ES), title('Edges and Sobel regions')
subplot(1,6,6), subimage(ME), title('MSER regions and Edges')
hold off;
pause(2);

%% Put them together
 final= sobelMask & mserMask; % We're using the sobel and mserMask to find words based on looking at sample plots for images above.
% figure; imshow(final);
% title('Intersection of sobel and edge')
% 
% pause(2);
% figure;imshow(final, []);
end

