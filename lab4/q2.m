close all
clear all

h = fspecial('disk',4);
f = im2double(imread('images/cameraman.tif'));
hfreq = fft2(h, size(f,1), size(f,2));  % pad h
fblur = real(ifft2(hfreq.*fft2(f)));

psnr(f, fblur);

corrected = real(ifft2(fft2(fblur) ./ hfreq));
psnr(f, corrected);
imshow(corrected);

fblur = imnoise(fblur, 'gaussian',0, 0.002);
corrected_gaussian = real(ifft2(fft2(fblur) ./ hfreq));
psnr(f, corrected_gaussian);
imshow(corrected_gaussian);

corrected_wiener = deconvwnr(fblur, real(ifft2(hfreq)), 50);

% figure
% imshow(fblur);
% figure
imshow(corrected_wiener);




