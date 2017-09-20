close all;
clear all;

img_a = imread('~/Downloads/cameraman.tiff');
img_b_inter = imresize(img_a, 0.25, 'bilinear');
img_b_inter = imresize(img_b, 4, 'bilinear');
error = psnr(img_a, img_b);
% imshow(img)