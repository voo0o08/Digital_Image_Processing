clc
clear all
close all

I=imread('Lee.jpg');
I=rgb2gray(I);
I = imnoise(I,'salt & pepper',0.02);
figure(1);subplot(1,2,1);imshow(I);title('noise image','fontsize',13);
I = medfilt2(I);
subplot(1,2,2);imshow(I);title('median filter','fontsize',13);

