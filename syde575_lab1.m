clear all;
close all;

img_a = imread('~/Downloads/tire.tif');
% Check that the size of the image is a multiple of 4
rem_x = mod(size(img_a, 1), 4);
rem_y = mod(size(img_a, 2), 4);
img_a = img_a(1:size(img_a,1) - rem_x, 1:size(img_a, 2) - rem_y);
      
img_b_small = imresize(img_a, 0.25, 'bilinear');

%% Nearest Neighbor
img_b_near = imresize(img_b_small, 4, 'nearest');
error_near = psnr(img_a, img_b_near);

%% Bilinear Interpolation
img_b_bil = imresize(img_b_small, 4, 'bilinear');
error_bil = psnr(img_a, img_b_bil);

%% Cubic Interpolation
img_b_cubic = imresize(img_b_small, 4, 'cubic');
error_cubic = psnr(img_a, img_b_cubic);