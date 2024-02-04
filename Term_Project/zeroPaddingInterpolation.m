clc
clear all
close all
tic
testImage = "[크기변환]woman.png";
compareImage = "woman.png";
Ireference = imread(testImage);
Ireference = im2double(Ireference);
Icompare = imread(compareImage);
Icompare = im2double(Icompare);
figure(1); imshow(Ireference)

[m n refCh] = size(Ireference);
[p q comCh] = size(Icompare);

refF = fft2(Ireference);
paddingSize = 4;

% upsampleF0 = zeros(p,q,comCh);
% ii = 1; jj = 1;
% for i=1:paddingSize:p
%     for j=1:paddingSize:q
%         upsampleF0(i,j,1) = refF(ii,jj,1);
%         upsampleF0(i,j,2) = refF(ii,jj,2);
%         upsampleF0(i,j,3) = refF(ii,jj,3);
%         jj = jj + 1;
%     end
%     jj = 1;
%     ii = ii + 1;
% end
% upsampleF0 = upsampleF0*(paddingSize^2);
% Iupsample0 = real(ifft2(upsampleF0));

upsampleF = zeros(p,q,comCh);

for i=1:comCh
    upsampleF(1:p/8, 1:q/8,i) = refF(1:m/2, 1:n/2,i);
    upsampleF(1:p/8, (q*7/8)+1:q,i) = refF(1:m/2, (n/2)+1:n,i);
    upsampleF((p*7/8)+1:p, 1:q/8,i) = refF((m/2)+1:m, 1:n/2,i);
    upsampleF((p*7/8)+1:p, (q*7/8)+1:q,i) = refF((m/2)+1:m, (n/2)+1:n,i);
end

upsampleF = upsampleF*(paddingSize^2);
Iupsample = real(ifft2(upsampleF));
a = upsampleF(:,:,1);
figure(2); imagesc(Iupsample);
title("Zero Padding Implementation")

figure(3); imagesc(Icompare);
title("Compare Image")
toc
% figure(4); imagesc(Iupsample0);
% title("Zero Padding Implementation0")

[psr nr] = psnr(Iupsample, Icompare)



(1.368367+1.119336+1.175267+1.083501+1.205370)/5


