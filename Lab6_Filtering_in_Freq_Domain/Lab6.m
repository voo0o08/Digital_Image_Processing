clc
clear all
close all

%% step 1 
% f(x,y) of size MxN, obtain the padding parameters P(=2M) and Q(=2N)
I = imread('circuit.png');
I = rgb2gray(I);
figure(1); subplot(3,3,1),imshow(I); title('input');
[M, N] = size(I);
P = 2*M; Q = 2*N;
%F(1,1)=15493085

%% step 2. 제로 패딩으로 PxQ행렬 만들기
%Form a padded image, fp(x,y) of PxQ by appending the necessary number of zeros to f(x,y)
padded_im = zeros(P,Q);
padded_im(1:M,1:N) =  double(I);

subplot(3,3,2),imshow(uint8(padded_im)); title('padded image');

%% step 3. 대칭적인 주파수 domain 이미지 획득을 위함
% Multiply fp(x,y) by (-1)^(x+y) to center its transform = shift 효과

for i = 1:P
    for j = 1:Q
        padded_im(i,j) = padded_im(i,j)*(-1)^(i+j);
    end
end

subplot(3,3,3),imshow(uint8(padded_im)); title('Multiplying by (-1)**(x*y)');
%% step 4
% Compute the DFT, F(u,v) of the image from step3
F = fft2(padded_im); % DFT
%F(1,1)
subplot(3,3,4), imshow(log(abs(F)+1),[]); title('frequency');

%% step 5
% Generate a real, symmetric filter function, H(u,v),
% of size PxQ with center at coordinates(P/2, Q/2)
% 좌표 중심으로
u = 0:P-1; v = 0:Q-1;
u = u-P/2; v = v-Q/2;
% 거리 재기
[V, U] = meshgrid(v,u); %u,v를 행렬로
D = sqrt(U.^2+V.^2);
mean(D,'all')
max(D,[],'all')
D0 = 150; %cut-off freq
H = double(D<D0);

% H = zeros(P,Q);
% n = 2; % filter order
% D0 = 100; % cut-off frquency
% D = @(x,y) sqrt(x^2 + y^2);
% for i=1:P
% for j=1:Q
% H(i,j) = exp(-D(i - P/2,j - Q/2)^2/(2*D0^2));
% end
% end
% subplot(335)
% imshow(H,[]);

subplot(3,3,5), imshow(abs(H),[]); title('H');
%% step 6
% Form the product G(u,v) = H(u,v)F(u,v) using array multiplication
G = H.*F;
% magG = abs(G);
% subplot(2,2,3), imagesc(log(1+magG)); title('fitered spectrum');
subplot(3,3,6), imshow(log(abs(G)+1),[]); title('filtered frequency'); %필터링된 이미지의 주파수 domain

%% step 7
% Obtain the processed image
g = real(ifft2(G));
for i = 1:P
    for j = 1:Q
        g(i,j) = g(i,j)*((-1)^(i+j));
    end
end

g = uint8(g);

subplot(3,3,7), imshow(g); title('filtered image');

%% step 8
% Obtain the final processed result, g(x,y) 
% by extraction the MxN region from the top,left quadrant of gp(x,y)
result = g(1:M,1:N);
subplot(3,3,8), imshow(result); title('recovery image');

%%
g_filtered = imgaussfilt(I,4,'Padding',0,'FilterDomain','spatial');
figure(2); imshow(g_filtered); title('Gaussian');

