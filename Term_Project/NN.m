% NN
clc
clear all
close all

input = imread("[크기변환]baby.png");
real_nn = imread("baby.png");

% input = imread("[크기변환]bird.png");
% real_nn = imread("bird.png");
% 
% input = imread("[크기변환]butterfly.png");
% real_nn = imread("butterfly.png");

% input = imread("[크기변환]head.png");
% real_nn = imread("head.png");

% input = imread("[크기변환]woman.png");
% real_nn = imread("woman.png");

t = now;

[in_row, in_col, rgb] = size(input);

val = 4;

out_rgb = zeros(round(in_row*val), round(in_col*val), rgb);
for rgb_level = 1:3
    rgb_1D = input(:,:,rgb_level);
    out = zeros(round(in_row*val), round(in_col*val));
    [out_row, out_col] = size(out);
    
    x = ceil((1:out_col)/val);
    y = ceil((1:out_row)/val);
    
    for i = 1:out_row
        for j = 1:out_col
            x_n = x(j);
            y_n = y(i);
            out(i,j) = rgb_1D(y_n, x_n);
        end
    end
    out_rgb(:,:,rgb_level) = out;
end

my_nn = uint8(out_rgb);

%% plot 
fprintf("구현 함수 \n")
t = now-t
nn_psnr = psnr(real_nn, my_nn)

% err = immse(real_nn, my_nn)

fprintf("내장 함수 \n")
t = now;
built_in_nn = imresize(input, val, 'nearest');
t = now-t
nn_psnr = psnr(real_nn, built_in_nn)


figure(1);
subplot(1,3,1); imshow(real_nn);title('원본','fontsize',20);
subplot(1,3,2); imshow(my_nn); title('구현 이미지','fontsize',20); 
subplot(1,3,3); imshow(built_in_nn); title('imresize 이미지','fontsize',20); 

