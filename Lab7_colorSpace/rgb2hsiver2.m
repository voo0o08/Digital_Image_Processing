function [H,S,V] =  rgb2hsi(input)

I=im2double(input);
R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);

% V
V = max(max(R,G),B);

% S
S=[];
min_rgb = min(R,min(G,B));
[row col] = size(V);
for i = 1:row
    for j = 1:col
        if V(i,j)==0
            S(i,j) = 0;
        else
            S(i,j) = (V(i,j)-min_rgb(i,j))./V(i,j);
        end
    end
end

% H
H = [];
for i = 1:row
    for j = 1:col
        if V(i,j)==R(i,j)
            H(i,j) = (60*(G(i,j)-B(i,j)))./(V(i,j)-min_rgb(i,j));
        elseif V(i,j)==G(i,j)
            H(i,j) = 120+(60*(B(i,j)-R(i,j)))./(V(i,j)-min_rgb(i,j));
        elseif V(i,j)==B(i,j)
            H(i,j) = 240+(60*(R(i,j)-G(i,j)))./(V(i,j)-min_rgb(i,j));
        end
                
        if H(i,j) < 0
            H(i,j) = H(i,j) + 360; 
        end   
    end
end

end

