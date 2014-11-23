function [ final ] = thresholdImage( I )
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
figure('Name','Original Grayscale');imshow(img);

final = img;

%% Convolve image with specific kernel
% smooth = imfilter (img, (ones (5)/25)); %average filter 5*5
% kernel = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
% final = conv2(double(final), kernel);
% figure('Name', 'kernel filter');imshow(final);


%% im2bw
threshold = graythresh(final);
final = ~im2bw(final, threshold);
pause(0.5);
figure('Name','im2bw based on thresh');imshow(final);
%% Perform edge detection
final = edge(final);
pause(0.5);
figure('Name','im2bw based on thresh');imshow(final);
%% rem < 30 pixels 
% final = bwareaopen(final,30);
% pause(0.5);
% figure('Name','rem < 30 pixels');imshow(final);

%% Special sobel
% final = conv2(double(final), fspecial('sobel'));
% pause(0.5);
% figure('Name', 'sobel filter');imshow(final);

pause(0.5);
figure;imshow(final, []);
end

