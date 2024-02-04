clc
clear all
close all

load("trainedVDSRNet.mat");

testImage = "[크기변환]woman.png";
compareImage = "woman.png";
Ireference = imread(testImage);
Ireference = im2double(Ireference);
Icompare = imread(compareImage);
Icompare = im2double(Icompare);
figure(1); imshow(Icompare)
title("Compare Image")

[nrows,ncols,np] = size(Icompare);
Iycbcr = rgb2ycbcr(Ireference);
Iy = Iycbcr(:,:,1);
Icb = Iycbcr(:,:,2);
Icr = Iycbcr(:,:,3);

Iy_bicubic = imresize(Iy,[nrows ncols],"bicubic");
Icb_bicubic = imresize(Icb,[nrows ncols],"bicubic");
Icr_bicubic = imresize(Icr,[nrows ncols],"bicubic");

Iresidual = activations(net,Iy_bicubic,41);
Iresidual = double(Iresidual);
figure(2); imshow(Iresidual,[])
title("Residual Image from VDSR")

Isr = Iy_bicubic + Iresidual;
Ivdsr = ycbcr2rgb(cat(3,Isr,Icb_bicubic,Icr_bicubic));
figure(3); imshow(Ivdsr)
title("High-Resolution Image Obtained Using VDSR")

[psr nr] = psnr(Ivdsr, Icompare)












