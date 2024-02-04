%22012383 Lee YunSeo
function [out] = myResizeBil(input, val)

[in_row, in_col] = size(input);

x = in_col*val+1; %x*1.47 = out size
y = in_row*val+1;

x_val = [1:x]/val;
y_val = [1:y]/val;

x_weight = [];
y_weight = [];

for i = 1:y
    for j = 1:x
        %weight
        x_w = ceil(x_val(j))-x_val(j); 
        y_w = ceil(y_val(i))-y_val(i);
        x_weight(j) = x_w;
        y_weight(i) = y_w;
    end
end

result = [];
for i = 1:y
    for j = 1:x
        %weight
        a = floor(x_val(j));
        a_1 = ceil(x_val(j));
       
        if (a_1 > in_col)
            a_1 = in_col;
        end
        
        if (a == 0)
            a = 1;
        end

        b = floor(y_val(i));
        b_1 = ceil(y_val(i));

        if b == 0
            b = 1;
        elseif b>in_row
            b = in_row;
        end
        
        if b_1>in_row
            b_1 = in_row;
        end
        
        result(i,j) = input(b,a)*(y_weight(i))*(x_weight(j)) + input(b,a_1)*(y_weight(i))*(1-x_weight(j)) + input(b_1,a)*(1-y_weight(i))*(x_weight(j)) + input(b_1,a_1)*(1-y_weight(i))*(1-x_weight(j));
    end
end
result = uint8(result);


out = result;
