clc
clear all
close all

% discrete domain
input=imread('light.tif'); % gray image
input=rgb2gray(input);
[nj r] = imhist(input); %nj = amount of each value, r = intensity value
L=2^8;
[M N] = size(input);
MN = M*N;
Pr = nj/MN;
Sk = [];
p = [];
for i = 1:256
    sum = 0;
    for j = 1:i
        sum = sum + Pr(j);
    end
    p(i) = sum;
    Sk(i) = (L-1)*sum;
end

Ieq1D = Sk(input(:)+1); %r=0->index 1
Ieq2D = reshape(Ieq1D, [M, N]);
Ieq2D = uint8(Ieq2D);

imshow(Ieq2D)

% figure(1); bar(Pr)
% figure(2); plot(Sk)
% figure(3); plot(p)





%%
% 
% input=imread('light.tif'); % gray image
% input=rgb2gray(input);
% 
% [I_y, I_x] = size(input);
% out = [];
% 
% for i = 1:I_y
%     for j = 1:I_x
%         if input(i,j)<90
%             result = 0;
%         elseif input(i,j)>135
%             result = 255;
%         else
%             result = 255/(135-90)*(input(i,j)-90);            
%         end
%         out(i, j) = result;
%     end
% end
% out = uint8(out);
% figure(1);imshow(input);
% figure(2);imshow(out);
% 


%% example
% I = imread('dark.tif');
% figure(1); subplot(1,2,1); imshow(I); title("original");
% 
% % dark_histogram
% [count center] = hist(double(I(:)),0:255);
% figure(1); subplot(1,2,2); bar(center, count); title("histogram");
% 
% %light_histogram
% I = imread("light.tif");
% figure(2); subplot(1,2,1); imshow(I); title("original");
% [count center] = hist(double(I(:)),0:255);
% figure(2); subplot(1,2,2); bar(center, count); title("histogram");


