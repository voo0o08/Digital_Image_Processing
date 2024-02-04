%% RGB2HSV구현(RGB2HSI로 함수 만들기), color bar 넣기
clc
clear all
close all
I=imread("Lee.jpg");
% rgb2hsi
[H S I] = rgb2hsiver2(I);
figure(1); 
subplot(1,3,1);imagesc(H); colormap gray; colorbar; title('rgb2hsi Hue')
subplot(1,3,2);imagesc(S); colormap gray; colorbar; title('rgb2hsi Saturation')
subplot(1,3,3);imagesc(I); colormap gray; colorbar; title('rgb2hsi Intensity')

% using build in
I=imread("Lee.jpg");
hsi = rgb2hsv(I); %nomalized value 0~1이라서 imagesc로 해줘야함
H2 = hsi(:,:,1); %0~360인데 결과는 nomalize때문에 0~1로 나옴 밑에도 전부 마찬가지
figure(2); 
subplot(1,3,1);imagesc(H2); colormap gray; colorbar; title('rgb2hsv Hue')
S2 = hsi(:,:,2);
subplot(1,3,2);imagesc(S2); colormap gray; colorbar; title('rgb2hsv Saturation')
I2 = hsi(:,:,3); %밝기
subplot(1,3,3);imagesc(I2); colormap gray; colorbar; title('rgb2hsv Intensity')

% hsi2rgb();
[R, G, B] = hsi2rgb(hsi);
figure(3); 
result(:,:,1)=R;
result(:,:,2)=G;
result(:,:,3)=B;
imagesc(result)

% using build in
figure(4); 
imagesc(hsv2rgb(hsi));
