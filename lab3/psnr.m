function PSNR_out = psnr(img_f, img_g)
img_f = double(img_f);
img_g = double(img_g);
max_f = 255.0; % 8-bit image
mse = (1.0 / (size(img_f,1) * size(img_f,2))) * sum(sum((img_f - img_g).^2));
PSNR_out = 10*log10(double(max_f^2/double(mse)));