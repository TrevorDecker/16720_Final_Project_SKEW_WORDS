load filenames
load labels

for i = 1:length(filenames)
    im = imread(filenames{i});
    im = rgb2gray(im);
    pause
end