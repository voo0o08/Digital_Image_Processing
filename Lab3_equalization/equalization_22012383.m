clc
clear all
close all

% Equalization
I=imread('light.tif'); % gray image
I=rgb2gray(I);
h1=imhist(I,256);
Ieq=histeq(I,256);
h2=imhist(Ieq,256);
figure(1); subplot(2,3,1); imshow(I), title('Original');
subplot(2,3,4); bar(h1), title('Histogram');
subplot(2,3,2); imshow(Ieq), title('original Histogram equalized');
subplot(2,3,5); bar(h2), title('Histogram');

%% myeq, h3
myeq = myhisteq(I,256); % length(0:255)=256
h3 = imhist(myeq,256);
subplot(2,3,3); imshow(myeq), title('my Histogram equalized');
subplot(2,3,6); bar(h3), title('Histogram');
