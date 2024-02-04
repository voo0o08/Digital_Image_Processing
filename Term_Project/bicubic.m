% bicubic
clc
clear all
close all

% input = imread("[크기변환]butterfly.png");
% real_bic = imread("butterfly.png");

% input = imread("[크기변환]bird.png");
% real_bic = imread("bird.png");

% input = imread("[크기변환]baby.png");
% real_bic = imread("baby.png");

% input = imread("[크기변환]head.png");
% real_bic = imread("head.png");

input = imread("[크기변환]woman.png");
real_bic = imread("woman.png");

val = 4; % scale factor
t=now;
[in_row in_col rgb] = size(input); 
out = zeros(ceil(in_row*val), ceil(in_col*val)); % 2차원 출력 배열
[out_row out_col] = size(out); 
out_rgb = zeros(round(in_row*val), round(in_col*val), rgb); % 3차원 출력 배열
y = (1:out_row)/val+(0.5*(1-1/val)); % 확대된 좌표들의 y 위치
x = (1:out_col)/val+(0.5*(1-1/val)); % 확대된 좌표들의 x 위치

%%%%%%%%%%%%main%%%%%%%%%%%%%%
for rgb_level = 1:3
    rgb_1D = double(input(:,:,rgb_level)); %R->G->B 순서대로 연산
    % y값 정의
    for i = 1:out_row
        y1 = floor(y(i)) - 1;
        y1(y1 < 1) = 1;
        y1(y1 > in_row-3)=in_row - 3;
        dy = y(i)-y1-1; %-1번 기준
        % x값 정의
        for j = 1:out_col
            x1 = floor(x(j)) - 1;
            x1(x1 < 1) = 1;
            x1(x1 > in_col-3) = in_col-3;
            dx = x(j)-x1-1;
            for p = -1:2
                r_weight(p+2) = kernel1(dy-p); %y방향 가중치 -1번부터 2번까지
                c_weight(p+2) = kernel1(dx-p); %x방향 가중치
            end
            sum_x=sum(c_weight); sum_y=sum(r_weight);
            % 세로 방향부터 보간진행
            for k=0:3
                for p = 1:4
                    yy(p)=r_weight(p)*rgb_1D(y1+p-1,x1+k)/sum_y; %가중치*밝기값/가중치 합
                end
                Y(k+1) = sum(yy);
            end
            % Y(k+1)의 밝기값으로 가로방향 bicubic진행
            for k = 1:4
                X(k) = c_weight(k)*Y(k)/sum_x;
            end
            out(i,j)=sum(X);
        end
    end
    out_rgb(:,:,rgb_level) = out;
end
%% plot

my_bic=uint8(out_rgb);
fprintf("구현 함수 \n")
t = now-t
bic_psnr = psnr(real_bic, my_bic)

fprintf("내장 함수 \n")
t = now;
built_in_bic = imresize(input, val, 'bicubic');
t = now-t
bic_psnr = psnr(real_bic, built_in_bic)

figure(1);
subplot(1,3,1); imshow(real_bic);title('원본','fontsize',20);
subplot(1,3,2); imshow(my_bic); title('구현 이미지','fontsize',20); 
subplot(1,3,3); imshow(built_in_bic); title('imresize 이미지','fontsize',20); 

%% 가중치 커널
function h = kernel1(x)
x = abs(x);
a=-0.75;
% matlab과 opencv는 -0.75를 사용
if x<=1
    h = (a+2)*x^3   -(a+3)*x^2   +1;
elseif 1<x && x<=2
    h = a*x^3  -5*a*x^2   +8*a*x  -4*a;
else
    h = 0;
end
end