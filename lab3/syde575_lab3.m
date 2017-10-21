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

lena_fft = fft2(lena);
lena_fft = fftshift(lena_fft);

F_Mag = abs(lena_fft);
F_Phase = exp(1i*angle(lena_fft));


figure;
imshow(F_Mag,[-1 200],'InitialMagnification','fit','Colormap', jet); colorbar;

figure;
imshow(angle(F_Phase),[-pi pi],'InitialMagnification','fit', 'Colormap', jet); colorbar;

% Reconstructing from magnitude and phase only
I_Mag = log(abs(ifft2(F_Mag*exp(1i*0)))+1);
I_Phase = ifft2(F_Phase);

figure;
imshow(I_Mag);

figure;
imshow(abs(I_Phase), [min(min(abs(I_Phase))) max(max(abs(I_Phase)))]);

%% 3. Noise Reduction in the Frequency Domain
lena = imread('images/lena.tiff');
lena = rgb2gray(lena);
lena = im2double(lena);

% Adding noise to original image
lena_gauss = imnoise(lena, 'gaussian', 0.005);

% Log Fourier Spectra (Original)
f2 = log(fft2(lena));
f2_centered = fftshift(f2);

f2_gauss = log(fft2(lena_gauss));
f2_gauss_centered = fftshift(f2_gauss);

figure;
imshow(abs(f2_centered), [], 'Colormap', jet); colorbar;

figure;
imshow(abs(f2_gauss_centered), [], 'Colormap', jet); colorbar;

% Applying low pass filter (r = 60)
r = 60;
h = fspecial('disk',r); h(h > 0)=1;

h_freq = zeros(512,512);
h_freq([512/2-r:512/2+r],[512/2-r:512/2+r])=h;

figure;
imshow(h_freq);

f2_gauss_filtered = f2_gauss_centered.*h_freq;

figure;
imshow(abs(f2_gauss_filtered), [], 'Colormap', jet); colorbar;

I_f2 = ifft2(ifftshift(exp(f2_gauss_filtered)));

figure;
imshow(abs(I_f2));
psnr_r60 = psnr(lena, abs(I_f2));

% Applying low pass filter (r = 20)
r = 20;
h = fspecial('disk',r); h(h > 0)=1;

h_freq = zeros(512,512);
h_freq([512/2-r:512/2+r],[512/2-r:512/2+r])=h;

figure;
imshow(h_freq);
f2_gauss_filtered = f2_gauss_centered.*h_freq;

figure;
imshow(abs(f2_gauss_filtered), [], 'Colormap', jet); colorbar;

I_f2 = ifft2(ifftshift(exp(f2_gauss_filtered)));

figure;
imshow(abs(I_f2));
psnr_r20 = psnr(lena, abs(I_f2));

% Applying Gaussian low pass filter
f2_gauss_filtered = gaussian_lp_filter(f2_gauss_centered, 60);

figure;
imshow(abs(f2_gauss_filtered), [], 'Colormap', jet); colorbar;

I_f2 = ifft2(ifftshift(exp(f2_gauss_filtered)));

figure;
imshow(abs(I_f2));
psnr_gaussian = psnr(lena, abs(I_f2));

%% 4. Filter Design
f_noise = imread('images/frequnoisy.tif');
f_noise = im2double(f_noise);

figure;
imshow(f_noise);

f2 = log(fft2(f_noise));
f2 = fftshift(f2);

figure;
imshow(abs(f2), [] ,'Colormap' ,jet); colorbar;

% Find high amplitude outside centered circle of radius 15
g = custom_filter(f2, 8, 15);

figure;
imshow(abs(g), [], 'Colormap', jet); colorbar;

I_g = ifft2(ifftshift(exp(g)));

figure;
imshow(abs(I_g));