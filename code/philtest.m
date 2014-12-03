load labels
load filenames
cc = cell(62,1);
for i = 1:length(cc)
    cc{i} = [];
end
for i = 1 : length(filenames)
    im = imread(filenames{i});
    im = imresize(im,[50,70]);
    %bin = thresholdImage_v2(im);
    gray = rgb2gray(im);
    invert = backgroundshape(gray);
    if invert
            bin = gray < mean(mean(gray));
    else
            bin = gray > mean(mean(gray));
    end
    key = findind(labels{i})
    labels{i}
    if ~isempty(key)
        cc{key} = [cc{key}; bin(:)'];
        size(cc{key})
    end
        
    
end


%%
eigs = cell(62,1);
%%
for i = 1:26%27:length(cc)
    i
    if size(cc{i}) == 0
        eigs{i} = zeros(1,70*50);
        continue
    end
    covs = cc{i}' * cc{i};
    [V,D] = eig(covs);
    eigs{i} = V(:,end);
end

%%
load C:\Users\Phil\Documents\16720_Final_Project_SKEW_WORDS/eigs3.mat
%%
figure;
file = 'r.png'
im = imread(file);
im = imresize(im,[50, 70]);
subplot(1,3,1);
title('Original Picture');
imagesc(im)
if file(end-2:end) ~= 'bmp'
    gray = rgb2gray(im);
        invert = backgroundshape(gray);
        if invert
                bin = gray < mean(mean(gray))-10;
        else
                bin = gray > mean(mean(gray));
        end
    im = bin;
    coverage = sum(sum(im)) / (50*70);
    if coverage < .3
        spread = ones(5);
        im = conv2(double(im),spread) > 0;
        im = im(1:50,1:70);
    end
end

plt = subplot(1,3,2);
imagesc(im)

%im = bwmorph(im,'skel',Inf);
vals = [];
for i = 1:62
    val = max(eigs{i}' * im(:), -eigs{i}' * im(:));
    vals = [vals val];
    %imagesc(reshape(eigs{i},[50,70]));
    
end
string = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
[a,i] = sort(vals, 'descend');
string(i)
a(1)
subplot(1,3,3)
imagesc(reshape(eigs{i(1)},[50,70]));
title(plt, [int2str(a(1)) ' Match'])