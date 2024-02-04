function [H,S,V] =  rgb2hsi(input)

I=im2double(input);
R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);

% V
V = (R+G+B)/3;

% S
S=[];
min_rgb = min(R,min(G,B));
S = 1-3./(R+G+B).*min_rgb;

% H
[row, col] = size(S);
H = [];
up = 0.5*((R-G)+(R-B));
down = sqrt((R-G).^2+(R-B).*(G-B));
theta = acos(up./down);
for i=1:1:row
    for j=1:1:col
        if B(i,j)<=G(i,j)
            H(i,j) = theta(i,j);
        else 
            H(i,j) = 2*pi-theta(i,j);
        end
    end
end

H = H/(2*pi);
end