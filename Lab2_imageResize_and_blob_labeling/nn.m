%%
clc
clear all
close all

input = imread("Lee.jpg");
input = rgb2gray(input);

val = 1.47;
[in_row in_col] = size(input);

x = in_col*val+1; %x*1.47 = out size
y = in_row*val+1;

x_n = [1:x]/val;
y_n = [1:y]/val;

out = [];
for i = 1:y
    for j = 1:x
        x_in = round(x_n(j)); 
        y_in = round(y_n(i)); 
        out(i,j) = input(y_in, x_in);
    end
end

% for i = 1:y+1
%     for j = 1:x+1
%         x_n = round(j/val);
%         y_n = round(i/val);
%         out(i,j) = input(y_n,x_n);
%     end
% end
% 
% 
out = uint8(out);
result_nn2 = imresize(input, 1.47, 'nearest');
psnr(result_nn2, out)
% % figure(1);
% % imshow(out)

%%
clc
clear all
close all

input = imread("Lee.jpg");
input = rgb2gray(input);

val = 1.47;
[in_row in_col] = size(input);

out = zeros(ceil(in_row*val), ceil(in_col*val));
[out_row out_col] = size(out);

x = round((1:out_col)/val);
y = round((1:out_row)/val);

a = [];
b = [];
for i = 1:out_row
    for j = 1:out_col
       x_n = x(j);
       y_n = y(i);
       out(i,j) = input(y_n, x_n);
    end
end
out = uint8(out);
result_nn2 = imresize(input, 1.47, 'nearest');
psnr(result_nn2, out)
% figure(1);
% imshow(out)

%%
clc
clear all
close all

input = imread("Lee.jpg");
input = rgb2gray(input);

val = 1.47;
[in_x in_y] = size(input);

out = zeros(ceil(in_x*val), ceil(in_y*val));
[out_x out_y] = size(out);

x = round((1:out_x)/val);
y = round((1:out_y)/val);

for i = 1:out_y
    for j = 1:out_x
       x_n = x(j);
       y_n = y(i);
       out(j,i) = input(x_n, y_n);
    end
end
out = uint8(out);

figure(1);
imshow(out)
