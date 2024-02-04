function [out] = myhisteq(input,n) %input = image, n = intensity level range

% discrete domain

[nj r] = imhist(input); %nj = amount of each value, r = intensity value
L=n;
[M N] = size(input);
MN = M*N;
Pr = nj/MN;
Sk = [];
% p = [];
for i = 1:256
    sum = 0;
    for j = 1:i
        sum = sum + Pr(j);
    end
%     p(i) = sum;
    Sk(i) = (L-1)*sum;
end

Ieq1D = Sk(input(:)+1); %r=0->index 1
out = reshape(Ieq1D, [M, N]); %Ieq2D


out = uint8(out);