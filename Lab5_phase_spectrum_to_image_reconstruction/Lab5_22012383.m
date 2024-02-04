clc
clear all
close all

im1 = imread('Lee.jpg');
[M, N, z] = size(im1); 
%뒤에서 rectangle 이미지와 크기를 맞추기 위함
im1 = rgb2gray(im1);
figure(1), subplot(2,3,1), imshow(im1), title('input image'); %원본 이미지를 출력한다
im1_X = fft2(im1); %푸리에 변환
im1_phase = angle(im1_X); %각도 값 
im1_mag = abs(im1_X); %크기 값

% phase 출력
subplot(2,3,2), imshow(im1_phase,[]), title('phase');

% only using phase reconstruction
I3 = ifft2(exp(1i*im1_phase));
subplot(2,3,3), imshow(I3,[]), title('only phase');

% only using magnitude reconstruction
x = ifft2(im1_mag); % 푸리에 역변환 주파수 영역 to 공간 영역
I4 = fftshift(x);

I4 = 1 * log(1 + double(I4)/255); %밝기 값을 높인다
subplot(2,3,4), imshow(I4,[]), title('only magnitude');

im2 = imread('rectangle.tif'); % 사각형 이미지를 load
im2 = imresize(im2,[M,N]); % input이미지와 배열 크기를 맞춰줌
im2_X = fft2(im2);
im2_phase = angle(im2_X); % 각도 값
im2_amp = abs(im2_X); % 크기 값

im1_exp_im2 = im1_mag.*(exp(1i*im2_phase));
im2_exp_im1 = im2_amp.*(exp(1i*im1_phase));

im1_exp_im2 = ifft2(im1_exp_im2);
im2_exp_im1 = ifft2(im2_exp_im1);

subplot(2,3,6); imshow(im1_exp_im2,[]); title('rec phase, my mag');
subplot(2,3,5); imshow(im2_exp_im1,[]); title('my phase, rec mag');

%%
% clc
% close all
% clear all
% 
% i1=imread('face.png'); 
% i1=rgb2gray(i1); figure,imshow(i1); 
% 
% f1=fft2(i1); 
% mag1=abs(f1); 
% phase1=exp(1i * angle(f1)); 
% 
% a1=ifftn(mag1); 
% a2=ifftn(phase1); 
% 
% a3=fft2(a1).*fft2(a2); 
% a4=ifft2(a3);
% 
% figure,imshow(uint8(a4));

% clc
% close all
% clear all
% 
% i1=imread('face.png'); 
% i1=rgb2gray(i1); figure,imshow(i1); 
% 
% f1=fft2(i1); 
% mag1=abs(f1); 
% phase1=(angle(f1)); 
% 
% a3 = mag1.*(exp(1i*phase1));
% a4=ifft2(a3);
% 
% figure,imshow(uint8(a4));