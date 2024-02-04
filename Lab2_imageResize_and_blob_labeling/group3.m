clc
clear all
close all
% load a gray image
grayImage = imread('rice.png'); 

% thresholding
brightBlobs = grayImage > 128; % Find bright things.


BW = brightBlobs;
con_n = 8; %4or8conneted
result = [];
c = 1;
[BW_y BW_x] = size(BW);
if con_n == 8
    for i = 1:BW_y
        for j = 1:BW_x
            up = i-1;
            down = i+1;
            left = j-1;
            right = j+1;
            X = BW(i,j);
            
            if X == 1
                
                if  i == 1
                    A = 0;
                    B = 0;
                    C = 0;
                    if j == 1
                        D = 0;
                    else
                        D = result(i,left);
                    end
                else %A,B,Cooooooo
                    if j == 1 
                        A = 0;
                        C = result(up, right);
                        D = 0;
                    elseif j == BW_x
                        A = result(up,left);
                        C = 0;
                        D = result(i,left);
                    else
                        A = result(up,left);
                        C = result(up, right);
                        D = result(i, left);
                    end
                    B = result(up,j);
                end

                if i == 1 & j == 1
                    A = 1;
                    B = 1;
                    C = 1;
                    D = 1;
                end
                sur = unique([0,A,B,C,D]);
                [sur_row, sur_col]= size(sur); 

                if sur_col == 1
                    c = c+1;
                    result(i,j) = c; 
                elseif sur_col == 2
                    result(i,j) = sur(2);
                else 
                    result(i,j) = sur(2);
                    low = sur(2);
                    for m = 1:j
                        for n = 1:i
                            if (result(n,m) == sur(3))
                                result(n,m) = sur(2);
                            end
                        end
                    end
                end
 
            else
                result(i,j) = 0; %backround color = 0
            end
            
        end
    end
end

% labeling
L2 = bwlabel(brightBlobs,8); % blob labeling with 8 adjacency
figure(1),subplot(1,2,1);imagesc(L2); colorbar; title('bwlabel');subplot(1,2,2); imagesc(result); colormap jet
title('Blob labeling my code'); colorbar;