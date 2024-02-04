% hsi2rgb.m
clc
clear all
close all

I=imread("Lee.jpg");
hsi = rgb2hsv(I);
H = hsi(:,:,1); %0~360인데 결과는 nomalize때문에 0~1로 나옴 밑에도 전부 마찬가지
S = hsi(:,:,2);
V = hsi(:,:,3); %밝기

[R1, G1, B1]=hsv2rgb(hsi);
H = H*2*pi;

[row col] = size(H);

for i = 1:row
    for j = 1:col
        if 0 <= H(i,j) &  H(i,j)<2*pi/3
            B(i,j) = V(i,j).*(1-S(i,j));
            R(i,j) = V(i,j).*(1+(S(i,j).*cos(H(i,j)))./cos(pi/3-H(i,j)));
            G(i,j) = 3*V(i,j)-(R(i,j)+B(i,j));
        elseif 2*pi/3 <= H(i,j) &  H(i,j) < 4*pi/3
            H(i,j) = H(i,j)-2*pi/3;
            R(i,j) = V(i,j).*(1-S(i,j));
            G(i,j) = V(i,j).*(1+(S(i,j).*cos(H(i,j)))./cos(pi/3-H(i,j)));
            B(i,j) = 3*V(i,j)-(R(i,j)+G(i,j));
        else
            H(i,j) = H(i,j)-4*pi/3;
            G(i,j) = V(i,j).*(1-S(i,j));
            B(i,j) = V(i,j).*(1+(S(i,j).*cos(H(i,j)))./cos(pi/3-H(i,j)));
            R(i,j) = 3*V(i,j)-(G(i,j)+B(i,j));
        end
    end
end

A(:,:,1) = R;
A(:,:,2) = G;
A(:,:,3) = B;
imagesc(A)
