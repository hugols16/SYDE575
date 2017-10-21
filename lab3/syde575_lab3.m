clear all;
close all;

%% Fourier Analysis

f = zeros(256,256);
f(:,108:148)=1;

figure;
imshow(f, 'InitialMagnification', 'fit');

figure;

f_fft = fft2(f);
f2 = log(abs(f_fft));
f_fft_centered = fftshift(f2);
imshow(f_fft_centered,[-1,10],'InitialMagnification','fit', 'Colormap', jet); colorbar;

% Rotate
f_45 = imrotate(f, 45);
figure;
imshow(f_45, 'InitialMagnification', 'fit');

figure;

f_45_fft = fft2(f_45);
f2_45 = log(abs(f_45_fft));
f_45_fft_centered = fftshift(f2_45);
imshow(f_45_fft_centered,[-1,10],'InitialMagnification','fit', 'Colormap', jet); colorbar;

% Lena Image
lena = imread('images/lena.tiff');
lena = rgb2gray(lena);
lena = im2double(lena);

