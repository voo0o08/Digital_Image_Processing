%22012383 Lee YunSeo
%% 4adjacency
clc
clear all
close all

val = 4; %4adjacency
BW = logical ([1 1 1 0 0 0 0 0
1 1 1 0 1 1 0 0
1 1 1 0 1 1 0 0
1 1 1 0 0 0 1 0
1 1 1 0 0 0 1 0
1 1 1 0 0 0 1 0
1 1 1 0 0 1 1 0
1 1 1 0 0 0 0 0]);
L = bwlabel(BW,val); % blob labeling with 4/8 adjacency
result = [];
c = 1; %color number count
if val == 4
    for i = 1:8
        for j = 1:8
            up = i-1;
            left = j-1;

            X = BW(i,j);
            if X == 1
                
                if  i == 1
                    A = 0;
                else
                    A = result(up,j);
                end
                
                if j == 1
                    B = 0;
                else
                    B = result(i,left);
                end
                
                if i == 1 & j == 1
                    A = 1;
                    B = 1;
                    
                end
                sur = unique([0,A,B]); %duplication remove and sorting
                [sur_row, sur_col]= size(sur); 

                if sur_col == 1
                    c = c+1; %color count + 1
                    result(i,j) = c; 
                elseif sur_col == 2
                    result(i,j) = sur(2);
                else 
                    result(i,j) = sur(2);
                    result(i,j-1) = sur(2);
                end
 
            else
                result(i,j) = 0; %backround color = 0
            end
            
        end
    end
end

figure(1); subplot(1,3,1); imagesc(BW), colorbar; title('before')
subplot(1,3,2); imagesc(L); colormap jet; colorbar; title('bwlabel')
subplot(1,3,3); imagesc(result); colorbar; title('22012383 Lee YunSeo')

%% 8adjacency

val = 8; %8conneted
L = bwlabel(BW,val);
result = [];
c = 1; %color number count

if val == 8
    for i = 1:8
        for j = 1:8
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
                else
                    if j == 1
                        A = 0;
                    else
                        A = result(up,left);
                    end
                    B = result(up,j);
                    if j == 8
                        C=0;
                    else
                        C = result(up, right);
                    end
                end
                
                if j == 1
                    D = 0;
                else
                    D = result(i,left);
                end

                if i == 1 & j == 1
                    A = 1;
                    B = 1;
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
                    result(i,j-1) = sur(2);
                end
 
            else
                result(i,j) = 0; %backround color = 0
            end
            
        end
    end
end
figure(2); subplot(1,3,1); imagesc(BW), colorbar; title('before')
subplot(1,3,2); imagesc(L); colormap jet; colorbar; title('bwlabel')
subplot(1,3,3); imagesc(result); colorbar; title('22012383 Lee YunSeo')

%%
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
figure(3),subplot(1,2,1);imagesc(L2); colorbar; title('bwlabel');subplot(1,2,2); imagesc(result); colormap jet
title('22012383 Lee YunSeo'); colorbar;