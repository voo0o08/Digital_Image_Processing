%22012383 Lee YunSeo
function out = myResizeNN(input, val)
[in_row in_col] = size(input);

out = zeros(ceil(in_row*val), ceil(in_col*val));
[out_row out_col] = size(out);

x = round((1:out_col)/val);
y = round((1:out_row)/val);

for i = 1:out_row
    for j = 1:out_col
       x_n = x(j);
       y_n = y(i);
       if x_n == 0
           x_n = 1;
       elseif x_n>in_col
           x_n = in_col;
       elseif y_n == 0
           y_n = 1;
       elseif y_n>in_row
           y_n = in_row;
       end
       
       out(i,j) = input(y_n, x_n);
    end
end
out = uint8(out);

