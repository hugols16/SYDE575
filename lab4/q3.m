clear all
close all

cameraman = im2double(imread('images/cameraman.tif'));
f = im2double(imread('images/degraded.tif'));

% imshow(f);
% rect = getrect

% flat_region = f(48:86, 157:198);
% flat_region = f(11:65, 6:56);
flat_region = f(55:65, 170:180);


f_lee = lee_filter(f, flat_region);
f_gauss = imgaussfilt(f, 3);

figure
imshow(f);
figure
imshow(f_lee);
psnr_lee = psnr(cameraman, f_lee);
figure
imshow(f_gauss);
psnr_gauss = psnr(cameraman, f_gauss);