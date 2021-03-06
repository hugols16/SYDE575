close all;
clear all;

%% 2.0 Noise Generation
% Generating the synthetic toy image
f = [0.3*ones(200,100) 0.7*ones(200,100)];

% Adding noise to original image
f_gauss = imnoise(f, 'gaussian', 0.01);
f_sp = imnoise(f, 'salt & pepper', 0.05);
f_speckle = imnoise(f, 'speckle', 0.04);

figure;
imshow(f);
% title('Original Synthetic Toy Image');

figure;
imhist(f);
% title('Original Synthetic Toy Image Histogram');

figure;
imshow(f_gauss);
% title('Synthetic Toy Image with Gaussian Noise');

figure;
imhist(f_gauss);
% title('Synthetic Toy Image with Gaussian Noise Histogram');

figure;
imshow(f_sp);
% title('Synthetic Toy Image with S&P Noise');

figure;
imhist(f_sp);
% title('Synthetic Toy Image with S&P Noise Histogram');

figure;
imshow(f_speckle);
% title('Synthetic Toy Image with Speckle Noise');

figure;
imhist(f_speckle);
% title('Synthetic Toy Image with Speckle Noise Histogram');

%% 3.0 Noise Reduction in the Spatial Domain

lena = imread('images/lena.tiff');
lena = rgb2gray(lena);
lena = im2double(lena);

% Create the noisy image
lena_gauss = imnoise(lena, 'gaussian', 0.02);
PSNR = psnr(lena, lena_gauss);

figure;
imhist(lena_gauss);
title('Histogram of Lena with Gaussian Noise');

figure;
imshow(lena_gauss);
title('Lena Image with Gaussian Noise');

% Create the filter
filter_avg = fspecial('average');

figure;
colormap(gray);
imagesc(filter_avg);

% Apply the filter
lena_filtered = imfilter(lena_gauss, filter_avg);

figure;
imshow(lena_filtered);
title('Noisy Lena Image with Applied Average Filter');

figure;
imhist(lena_filtered);
title('Histogram of the Filtered Lena Image');

PSNR_lena = psnr(lena, lena_filtered);

%% 4.0 Sharpening in the Spatial Domain
cameraman = imread('images/cameraman.tif');
cameraman = im2double(cameraman);

% Applying Gaussian filter
filter_gauss = fspecial('gaussian', 7, 7);
cameraman_gauss = imfilter(cameraman, filter_gauss);

% Subtracting filtered image from the original image
cameraman_sub = cameraman - cameraman_gauss;

figure;
imshow(cameraman_gauss);
title('Cameraman Image Filtered with Gaussian Filter');

figure;
imshow(cameraman_sub);
title('Original Image with Gaussian Filtered Image Subtracted');

% Adding subtracted image to original image
cameraman_sub_add = cameraman + cameraman_sub;

figure;
imshow(cameraman_sub_add);
title('Original Image with Subtracted Image Added');

% Adding 0.5*subtracted image to original image
cameraman_sub_add_05 = cameraman + 0.5.*cameraman_sub;

figure;
imshow(cameraman_sub_add_05);
title('Original Image with Subtracted Image Added*0.5');