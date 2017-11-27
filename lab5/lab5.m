clear all;
close all;

%% Section 2 - Chroma Subsampling
peppers_png = imread('images/peppers.png');
peppers_ycbcr = rgb2ycbcr(peppers_png);

figure;
imshow(peppers_png);

a = zeros(384,512);

Y = peppers_ycbcr(:,:,1);
Cb = peppers_ycbcr(:,:,2);
Cr= peppers_ycbcr(:,:,3);

just_Y = cat(3, Y, a, a);
just_Cb = cat(3, a, Cb, a);
just_Cr = cat(3, a, a, Cr);

YY = ycbcr2rgb((just_Y));
CbCb = ycbcr2rgb(just_Cb);
CrCr = ycbcr2rgb(just_Cr);

YY_gray = rgb2gray(YY);
Cb_gray = rgb2gray(CbCb);
Cr_gray = rgb2gray(CrCr);

figure;
imshow(YY_gray);

figure;
imshow(CbCb);

figure;
imshow(CrCr);

% downsampling chroma channels
Cb_small = imresize(Cb, 0.25, 'bilinear');
Cr_small = imresize(Cr, 0.25, 'bilinear');

%Upsampling chroma channels
Cb_resize = imresize(Cb_small, 4, 'bilinear');
Cr_resize = imresize(Cr_small, 4, 'bilinear');

chroma_ycbcr = cat(3,Y, Cb_resize, Cr_resize);
chroma_rgb = ycbcr2rgb(chroma_ycbcr);

figure;
imshow(chroma_rgb);

% downsampling luma channel
Y_small = imresize(Y, 0.25, 'bilinear');

%Upsampling luma channel
Y_resize = imresize(Y_small, 4, 'bilinear');

luma_ycbcr = cat(3,Y_resize, Cb, Cr);
luma_rgb = ycbcr2rgb(luma_ycbcr);

figure;
imshow(luma_rgb);

%% Colour Segmentation
peppers_lab = rgb2lab(peppers_png);

% K-means
f = peppers_png;
im_lab = peppers_lab;

% K = 2;
% row = [55   200];
% col = [155   400];

K = 4;
row = [55    130   200  280];
col = [155   110   400  470];

% Convert (r,c) indexing to 1D linear indexing.
idx = sub2ind([size(f,1) size(f,2)], row, col);

ab = double(im_lab(:,:,2:3));  % NOT im2double
m = size(ab,1);
n = size(ab,2);
ab = reshape(ab,m*n,2);

% Vectorize starting coordinates
for k = 1:K
    mu(k,:) = ab(idx(k),:);
end

cluster_idx = kmeans(ab,k,'Start',mu);

% Label each pixel according to k-means
pixel_labels = reshape(cluster_idx, m, n);
h = figure,imshow(pixel_labels, [])
%title('Image labeled by cluster index for K=2');
colormap('jet')

% Show Cluster Colours

class1 = repmat(pixel_labels==1, [1 1 3]);
class2 = repmat(pixel_labels==2, [1 1 3]);
class3 = repmat(pixel_labels==3, [1 1 3]);
class4 = repmat(pixel_labels==4, [1 1 3]);

figure;
subplot(4,1,1), imshow(uint8(class1).*peppers_png);
title('Class 1');
subplot(4,1,2), imshow(uint8(class2).*peppers_png);
title('Class 2');
subplot(4,1,3), imshow(uint8(class3).*peppers_png);
title('Class 3');
subplot(4,1,4), imshow(uint8(class4).*peppers_png);
title('Class 4');