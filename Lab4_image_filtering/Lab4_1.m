%not this
clc
clear all
close all

%% linear filter: averaging filter
I=imread('pattern.tif');
figure(1);subplot(1,3,1); imshow(I); title('Original Image','fontsize',13);

% add Gaussian noise
n=randn(size(I))*20;
In=uint8(double(I)+n); 
%lst=find(In<0); In(lst)=0;
%lst=find(In>255); In(lst)=255;
subplot(1,3,2); imshow(In); title('Noisy Image','fontsize',13);

% averaging filter
w=ones(5,5)/25;
Ir=imfilter(In,w,'same',0);
subplot(1,3,3); imshow(Ir); title('Averaged Image','fontsize',13);
