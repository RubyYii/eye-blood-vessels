% Read the source image
clc;
clear all;
close all;
%image = imread('E:/eye blood vessels/06_test.tif');
image =imread('D:/Qiufeng/ML/Unet/unet_3/images/Training_Images/HSG002a.jpg');
% Extract the green channel from the source image
grayImg = image(:,:,2);

% Thresholding to create a mask
th0 = imbinarize(grayImg, 30 / 255);
mask = imerode(th0, ones(10, 10));

% Gaussian filtering
blurImg = imgaussfilt(grayImg,1);
% CLAHE
figure;
subplot(121);  
H1=adapthisteq(blurImg);  
imshow(H1); title('adapthisteq');  
subplot(122);  
imhist(H1);title('Histogram after equalisation'); 

% Display the images
figure; imshow(mask);
figure; imshow(blurImg);


%% 3.Matched filtering
homo=homofilter(H1);
figure; imshow(homo);title('homo');  
sigma=1;       %---->This is the 1st factor that affects the final result.
yLength=10;      %---->This is the 2nd factor that affects the final result.
% rL = 0.2;
% rH = 2;
direction_number=21;


MF = FrangiFilter(homo,sigma, yLength); %

mask=[0 0 1 0 0;  
      0 1 1 1 0;
      1 1 1 1 1;
      0 1 1 1 0;
      0 0 1 0 0;];
MF(mask==0) = 0;
MF = normalize(double(MF));
features = MF;      
figure;
subplot(221);
imshow(features*3);



im_adjust=imadjust(features,[0.1 0.3],[0 0.5]);  
subplot(222);imshow((im_adjust));
title('imadjust()');


[m,n]=size(th0);
mask2=im_adjust;
for i=1:m
    for j=1:n
        if th0(i,j)>0.5 & im_adjust(i,j)>0.4
            mask2(i,j)=255;
        else
            mask2(i,j)=0;
        end

    end
end
subplot(223);imshow((mask2));
title('mask2()');
%% 5.Image processing: noise point removal; breakpoint continuity; erosion expansion, etc.
result = medfilt2(mask2,[2 2]);
figure;
subplot(121);
imshow(result);
title('Median filtering');

SE=strel('disk',2); 



final=im_adjust;
for i=1:m
    for j=1:n
        if result(i,j)>0.5
            final(i,j)=255;
        else
            final(i,j)=0;
        end

    end
end
%final=final-img_out;

%expand=imerode(final,SE); 
final = imdiffusefilt(final);

figure();imshow(final);title('final');
