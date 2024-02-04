%implement the image filtering in Page 16/ assume zero padding
clc
close all
clear all

%% linear filter: averaging filter
I=imread('Lee.jpg');
I=rgb2gray(I);
figure(2);subplot(1,3,1); imshow(I); title('Original Image','fontsize',13);

% add Gaussian noise
n=randn(size(I))*20;
In=uint8(double(I)+n); 
subplot(1,3,2); imshow(In); title('Noisy Image','fontsize',13);

% averaging filter
w=ones(5,5)/25; %w = weight
%Ir=imfilter(In,w,'same',0);
Ir = myfilter(In,w,0);
subplot(1,3,3); imshow(Ir); title('My Averaged Image','fontsize',13);