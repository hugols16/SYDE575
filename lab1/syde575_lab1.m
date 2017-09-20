clear all;
close all;
 
%% Cameraman PSNR
img_a_camera = imread('images/cameraman.tif');
% Check that the size of the image is a multiple of 4
rem_x = mod(size(img_a_camera, 1), 4);
rem_y = mod(size(img_a_camera, 2), 4);
img_a_camera = img_a_camera(1:size(img_a_camera,1) - rem_x, 1:size(img_a_camera, 2) - rem_y);
      
img_b_small = imresize(img_a_camera, 0.25, 'bilinear');
 
% Nearest Neighbor
img_b_near = imresize(img_b_small, 4, 'nearest');
error_near_cameraman = psnr(img_a_camera, img_b_near);
 
% Bilinear Interpolation
img_b_bil = imresize(img_b_small, 4, 'bilinear');
error_bil_cameraman = psnr(img_a_camera, img_b_bil);
 
% Cubic Interpolation
img_b_cubic = imresize(img_b_small, 4, 'cubic');
error_cubic_cameraman = psnr(img_a_camera, img_b_cubic);
 
%% Lena PSNR
img_a_lena = imread('images/lena.tiff');
img_a_lena = rgb2gray(img_a_lena);
% Check that the size of the image is a multiple of 4
rem_x = mod(size(img_a_lena, 1), 4);
rem_y = mod(size(img_a_lena, 2), 4);
img_a_lena = img_a_lena(1:size(img_a_lena,1) - rem_x, 1:size(img_a_lena, 2) - rem_y);
      
img_b_small = imresize(img_a_lena, 0.25, 'bilinear');
 
%% Nearest Neighbor
img_b_near = imresize(img_b_small, 4, 'nearest');
error_near_lena = psnr(img_a_lena, img_b_near);
 
%% Bilinear Interpolation
img_b_bil = imresize(img_b_small, 4, 'bilinear');
error_bil_lena = psnr(img_a_lena, img_b_bil);
 
%% Cubic Interpolation
img_b_cubic = imresize(img_b_small, 4, 'cubic');
error_cubic_lena = psnr(img_a_lena, img_b_cubic);
 
 
%% Lena Convolution
lena = imread('images/lena.tiff');
lena = rgb2gray(lena);
lena = double(lena).*(1.0/255);
 
% Convolution Function
h1 = (1/6)*ones(1,6);
h2 = h1';
h3 = [-1 1];
 
lena_h1 = conv2(h1, lena);
lena_h2 = conv2(h2, lena);
lena_h3 = conv2(h3, lena);
 
%% Point Operation Enhancement
tire = imread('images/tire.tif');
