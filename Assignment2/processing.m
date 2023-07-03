img = imread("dog.jpg"); % read image
img = double(img)/255; % image normalization

% 1. Mean Filtering
% Gaussian noise
% mean = 0, standard_deviation = 0.1
noisy_img = img + 0.1*randn(size(img));

% Mean Filtering
kernel_sizes = [3, 5, 7];
filtered_imgs = {1:numel(kernel_sizes)};
for i = 1:numel(kernel_sizes)
    filter = ones(kernel_sizes(i))/(kernel_sizes(i)^2);
    filtered_imgs{i} = convn(noisy_img, filter, 'same');
end

subplot(2,2,1); imshow(img); title('Original Image');
subplot(2,2,2); imshow(noisy_img); title('Noisy Image');
subplot(2,3,4); imshow(filtered_imgs{1}); title('Kernel Size = 3');
subplot(2,3,5); imshow(filtered_imgs{2}); title('Kernel Size = 5');
subplot(2,3,6); imshow(filtered_imgs{3}); title('Kernel Size = 7');

% PSNR
h = size(noisy_img, 1); w = size(noisy_img, 2);
my_psnr = {1:numel(kernel_sizes)};
noisy_img = rgb2gray(noisy_img);
for j = 1:numel(kernel_sizes)
    filtered_imgs{j} = rgb2gray(filtered_imgs{j});
    mse = sum(sum((noisy_img-filtered_imgs{j}).^2))/(w*h);
    my_psnr{j} = 10*log10((0-256)^2/mse);
    fprintf('Kernel Size: %d\t', kernel_sizes(j));
    fprintf('PSNR: %f\n', my_psnr{j});
end

% 2. Unsharp Masking
kernel_sizes = [3, 5, 7];
smoothed_imgs = {1:numel(kernel_sizes)};
detail_imgs = {1:numel(kernel_sizes)};
sharpened_imgs = {1:numel(kernel_sizes)};

for i = 1:numel(kernel_sizes)
    % Smoothing Filter (Mean filtering)
    filter = ones(kernel_sizes(i))/(kernel_sizes(i)^2);
    smoothed_imgs{i} = convn(img, filter, 'same');
    % Detail (High-pass Filter)
    detail_imgs{i} = img - smoothed_imgs{i};
    % Sharpening
    sharpened_imgs{i} = img + 5*detail_imgs{i};
end

subplot(2,2,1); imshow(img); title('Original Image');
subplot(2,2,2); imshow(sharpened_imgs{1}); title('Kernel Size = 3');
subplot(2,2,3); imshow(sharpened_imgs{2}); title('Kernel Size = 5');
subplot(2,2,4); imshow(sharpened_imgs{3}); title('Kernel Size = 7');

% 3. Contrast Stretching
% (1) Contrast Stretching
cs_img = contrastStretching(img);

% (2) Gamma Correction
gc_img = gammaCorrection(img, 0.3);

% 4. Histogram Equalization
gray_img = rgb2gray(imread('dog.jpg'));
cdf = cumsum(imhist(gray_img));
cdf = cdf/numel(gray_img);
hist_img = reshape(cdf(gray_img(:)+1), size(gray_img));

subplot(1,2,1); imhist(gray_img); title('CDF before equalization');
subplot(1,2,2); imhist(hist_img); title('CDF after equalization ');

subplot(1,2,1); imshow(gray_img); title('Original Image');
subplot(1,2,2); imshow(hist_img); title('Histogram Equalization');

% 5. Image Upsampling
% Down-sample of original image
down_img = imresize(img, 0.25);

subplot(1,2,1); image(img); title('Original Image');
subplot(1,2,2); image(down_img); title('Down-sample');

% Up-sample of original image
scaling = projtform2d([4,0,0; ...
                       0,4,0; ...
                       0,0,1]);
up_img = imwarp(img, scaling);

% Nearest Neighbor
nn_img = imresize(img, 4, 'nearest');

% Bilinear
bil_img = imresize(img, 4, 'bilinear');

% Bicubig
bic_img = imresize(img, 4, 'bicubic');

subplot(2,2,1); image(up_img); title('Up-sample');
subplot(2,2,2); image(nn_img); title('Nearest Neighbor');
subplot(2,2,3); image(bil_img); title('Bilinear');
subplot(2,2,4); image(bic_img); title('Bicubic');

% PSNR
up_img = rgb2gray(up_img);
nn_img = rgb2gray(nn_img);
bil_img = rgb2gray(bil_img);
bic_img = rgb2gray(bic_img);

[h, w] = size(up_img);

nn_mse = sum(sum((up_img-nn_img).^2))/(w*h);
nn_psnr = 10*log10((0-256)^2/nn_mse);

bil_mse = sum(sum((up_img-bil_img).^2))/(w*h);
bil_psnr = 10*log10((0-256)^2/bil_mse);

bic_mse = sum(sum((up_img-bic_img).^2))/(w*h);
bic_psnr = 10*log10((0-256)^2/bic_mse);

fprintf('PSNR (Nearest Neighbor): %f\n', nn_psnr);
fprintf('PSNR (Bilinear): %f\n', bil_psnr);
fprintf('PSNR (Bicubic): %f\n', bic_psnr);