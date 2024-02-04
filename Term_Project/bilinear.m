% bilinear

clc
clear all
close all
% 
% input = imread("[크기변환]butterfly.png");
% real_bil = imread("butterfly.png");  % 4배 큰 원본
% 
% input = imread("[크기변환]bird.png");
% real_bil = imread("bird.png");

% input = imread("[크기변환]baby.png");
% real_bil = imread("baby.png");
% 
% input = imread("[크기변환]head.png");
% real_bil = imread("head.png");

input = imread("[크기변환]woman.png");
real_bil = imread("woman.png");

t = now;

[in_row, in_col, rgb] = size(input);
val = 4;

x = in_col*val;
y = in_row*val;

y_val = (1:y)/val+(0.5*(1-1/val));
x_val = (1:x)/val+(0.5*(1-1/val));

x_weight = [];
y_weight = [];

out_rgb = zeros(round(in_row*val), round(in_col*val), rgb);

for rgb_level = 1:3
    rgb_1D = double(input(:,:,rgb_level));
    for i = 1:y % 가중치 생성을 위한 for문
        for j = 1:x
            x_w(j) = ceil(x_val(j))-x_val(j); % 픽셀 간 거리값
            y_w(i) = ceil(y_val(i))-y_val(i);
        end
    end
    pad_image = double(padarray(rgb_1D,[1 1],'symmetric')); % index에러 방지를 위한 패딩
    result = [];
    for i = 1:y
        for j = 1:x
            %weight
            a = floor(x_val(j))+1;
            a_1 = ceil(x_val(j))+1;
            b = floor(y_val(i))+1;
            b_1 = ceil(y_val(i))+1;
            out(i,j) = pad_image(b,a)*(y_w(i))*(x_w(j)) + pad_image(b,a_1)*(y_w(i))*(1-x_w(j)) + ...
                pad_image(b_1,a)*(1-y_w(i))*(x_w(j)) + pad_image(b_1,a_1)*(1-y_w(i))*(1-x_w(j));
        end
    end
    out_rgb(:,:,rgb_level) = out;
end
%% plot
my_bil = uint8(out_rgb);

fprintf("구현 함수 \n")
t = now-t
my_bil_psnr = psnr(real_bil, my_bil)

fprintf("내장 함수 \n")
t = now;
built_in_bil = imresize(input, val, 'bilinear');
t = now-t
psnr_bil_psnr = psnr(real_bil, built_in_bil)

figure(1);
subplot(1,3,1); imshow(real_bil);title('원본','fontsize',20);
subplot(1,3,2); imshow(my_bil); title('구현 이미지','fontsize',20);
subplot(1,3,3); imshow(built_in_bil); title('imresize 이미지','fontsize',20);