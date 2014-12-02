function [ final ] = thresholdImage_v2( I,zoom)
%I is the rgb input image 
%zoom = 1 if the image is zoomed, 0 otherwise 

    size(I)

I = rgb2hsv(I);
if(zoom)
    %extends the border around the image so that even if the image is zoomed in
    %on a single letter the majority of the image is the backgorund color
    newI = 0.0*ones(2*size(I,1),2*size(I,2),3);
    newI(:,:,1) = I(1,1,1);
    newI(:,:,2) = I(1,1,2);
    newI(:,:,3) = I(1,1,3);
    xoffset_ = floor((size(newI,1) - size(I,1))/2);
    yoffset_ = floor((size(newI,2) - size(I,2))/2);
    for layer = 1:3
     newI(xoffset_+1:xoffset_+size(I,1),yoffset_+1:yoffset_+size(I,2),layer) = I(:,:,layer);
    end
    I = newI;
end
I = hsv2rgb(I);

%% resizes the input image so that run time and scale is regulated 
if(~zoom)
    rSize = 1000/size(I,2)
    I = imresize(I, rSize);
end

if(zoom)
    xSize = 2*size(I,1);
    ySize = 2*size(I,2);
else
    xSize = 100;
    ySize = 100;
end
result = zeros(size(I,1),size(I,2));
for x_start = 1:xSize/2:size(I,1)
   for y_start = 1:ySize/2:size(I,2)
    x_end = min(x_start+xSize,size(I,1));
    y_end = min(y_start+ySize,size(I,2));
    thisBlock = I(x_start:x_end,y_start:y_end,:);
    C = rgb2hsv(thisBlock);
    G = rgb2gray(thisBlock);
    
    C2 = C(:,:,2);
    [counts,x] = imhist(C2);
    peak = x(counts <mean(counts) == 0);
    C2_min = min(min(C2));
    C2_max = max(max(C2));
    if(C2_max - C2_min < .1)
        C2_result = 0;
    else
       C2_result = C2 >= peak(length(peak))+0;
    end
         
    C3 = C(:,:,3);
    [counts,x] =  imhist(C3);
    peak = x(counts < mean(counts) == 0);
    a = peak(1);
    
    C3_min = min(min(C3));
    C3_max = max(max(C3));

    if(C3_max - C3_min < .1)
        C3_result = 0;
    else
       C3_result = C(:,:,3) <= peak(1)+0;
    end
    [counts,x] =  imhist(G);
    peak = x(counts < mean(counts) == 0);
    peak(1);
    G_mean = mean(mean(G));
    G_min = min(min(G));
    G_max = max(max(G));
    if(G_max - G_min < .1)
        G_result = 0;
    else
        G_result = G <= peak(1)+ 0;
    end
    thisResult =  G_result+ C3_result +C2_result;
    thisResult = bwareaopen(thisResult,10);
   result(x_start:x_end,y_start:y_end) = result(x_start:x_end,y_start:y_end)+thisResult ;
    end
end
if(zoom)
    %shrink image back to orignal size
    [xoffset_, size(I,1) - xoffset_]
    a = size(result,1)./4;
    b = size(result,2)./4;
    result = result(a+1:size(I,1)-a,b+1:size(I,2)-b);
    size(result)
else
    I = imresize(I, 1/rSize);
end
imshow(result>0,[])


                                  
                                  
final = 0;
end
