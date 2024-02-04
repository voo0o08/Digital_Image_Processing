%myfilter
function [out] = myfilter(In,w,padding_val) %input = image, n = intensity level range
[w_M w_N] = size(w); %w_M = w_N
pad_n = floor(w_M/2);

[M N] = size(In);
pad_im = [];

%make size of pad_im
for i=1:(M+pad_n*2)
    for j=1:(N+pad_n*2)
        pad_im(i,j) = 0;
    end
end

[y x] = size(pad_im);
pad_im(1+pad_n:y-pad_n,1+pad_n:x-pad_n) = In(:,:);

out = [];
f = [];
for i = 1+pad_n:y-pad_n
    for j = 1+pad_n:x-pad_n
        
        g = sum(w(:,:).*pad_im(i-pad_n:i+pad_n,j-pad_n:j+pad_n),'all')/sum(w,'all');

        out(i-pad_n,j-pad_n) = g;
    end
end

out = uint8(out);