clear;
inp = fileread('Input3.txt');
expr_do = strfind(inp,'do()')+3;
expr_dont = strfind(inp,"don't()")+8;
add_mul = 0;
n=1;
delete_idx = [];
while n <= length(expr_dont)
    idx1 = expr_dont(n);
    idx2 = expr_do(expr_do>idx1);
    idx2 = idx2(1);
    delete_idx = [delete_idx, idx1:idx2];
    n = n + sum(expr_dont(n:end)<idx2);
end
inp(delete_idx) = [];
expr = strfind(inp,'mul(')+4;
for i = expr
    sub_string = inp(i:i+7);
    num = textscan(sub_string, '%3d', 'Delimiter',',');
    if (length(num{1}) == 2) & (sub_string(floor(log10(double(num{1}(1))))+floor(log10(double(num{1}(2))))+4) == ')')
        add_mul = add_mul + num{1}(1)*num{1}(2);
    end
end
disp(add_mul)