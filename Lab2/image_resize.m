%22012383 Lee YunSeo
clc
clear all
close all

input = imread("Lee.jpg");
input = rgb2gray(input);
val = 0.83;

my_bil = myResizeBil(input, val);
result_bil2 = imresize(input, val, 'bilinear');

my_nn = myResizeNN(input, val);
result_nn2 = imresize(input, val, 'nearest');

%2
figure(2);subplot(1,2,1); imshow(my_bil); title('22012383 Lee YunSeo bil','fontsize',14);subplot(1,2,2); imshow(result_bil2);title('Resizing using Bilinear','fontsize',14);
%3
figure(3);subplot(1,2,1); imshow(my_nn); title('22012383 Lee YunSeo nn','fontsize',14); subplot(1,2,2);imshow(result_nn2);title('Resizing using NN','fontsize',14);
bil_83 = psnr(result_bil2, my_bil)
nn_83 = psnr(result_nn2, my_nn)

%%

val = 1.47;

my_bil = myResizeBil(input, val);
result_bil2 = imresize(input, val, 'bilinear');

my_nn = myResizeNN(input, val);
result_nn2 = imresize(input, val, 'nearest');

%2
figure(4);subplot(1,2,1); imshow(my_bil); title('22012383 Lee YunSeo bil','fontsize',14);subplot(1,2,2); imshow(result_bil2);title('Resizing using Bilinear','fontsize',14);
%3
figure(5);subplot(1,2,1); imshow(my_nn); title('22012383 Lee YunSeo nn','fontsize',14); subplot(1,2,2);imshow(result_nn2);title('Resizing using NN','fontsize',14);
bil_147 = psnr(result_bil2, my_bil)
nn_147 = psnr(result_nn2, my_nn)

