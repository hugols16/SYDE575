close all
clear all

h = fspecial('disk',4);
f = im2double(imread('images/cameraman.tif'));
hfreq = fft2(h, size(f,1), size(f,2));  % pad h
fblur = real(ifft2(hfreq.*fft2(f)));

figure;
imshow(fblur);
psnr_blur = psnr(f, fblur);

corrected = real(ifft2(fft2(fblur) ./ hfreq));
psnr_corrected = psnr(f, corrected);
figure;
imshow(corrected);

% With Gaussian Noise
f_gnoise = imnoise(fblur, 'gaussian',0, 0.002);
corrected_gaussian = real(ifft2(fft2(f_gnoise) ./ hfreq));
psnr_gaussian = psnr(f, corrected_gaussian);
figure;
imshow(corrected_gaussian);


% Corrected Wiener
noise_var = 0.002;
NSR = noise_var/var(f(:));

corrected_wiener = deconvwnr(f_gnoise, h, NSR);

figure;
imshow(corrected_wiener);
psnr_wiener = psnr(f, corrected_wiener);