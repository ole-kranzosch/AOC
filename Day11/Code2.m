clear;
%% Read input
inp = readmatrix("Input11.txt");
stones = inp;
blinks = 75;
multi = ones(size(stones));
for i=1:blinks
    unique_stones = unique(stones);
    new_multi = zeros(size(unique_stones));
    for p = 1:numel(unique_stones)
        new_multi(p) = sum(multi(stones==unique_stones(p)));
    end
    idx_0 = unique_stones==0;
    unique_stones(idx_0) = 1;

    idx_even = find(mod(floor(log10(unique_stones))+1,2) == 0);
    idx_even_log = false(size(unique_stones));
    idx_even_log(idx_even) = true;
    
    splitted_stones = split_in_half(unique_stones(idx_even))';
    unique_stones(~(idx_0 | idx_even_log)) = unique_stones(~(idx_0 | idx_even_log))*2024;
    new_stones = zeros(1,numel(unique_stones)+size(splitted_stones,2));
    idx_old = idx_even + (1:numel(idx_even))-1;
    idx_new = zeros(1,2*numel(idx_old));
    idx_new(1:2:end) = idx_old;
    idx_new(2:2:end) = idx_old+1;
    new_stones(idx_new) = splitted_stones(:);
    idx_keep = true(size(new_stones));
    idx_keep(idx_new) = false;
    new_stones(idx_keep) = unique_stones(~idx_even_log);
    stones = new_stones;
    multi = ones(size(stones));
    multi(idx_keep) = new_multi(~idx_even_log);
    multi(idx_new) = kron(new_multi(idx_even_log),[1 1]);

end
sprintf('%16.f',sum(multi))

function out = split_in_half(num)
    num = num(:);
    left = zeros(size(num));
    right = zeros(size(num));
    for k = 1:numel(num)
        N = num(k);
        m = floor(log10(N)); 
        digits = mod(floor(N ./ 10 .^ (m:-1:0)), 10);
        mid = numel(digits)/2;
        left(k) = (digits(1:mid)*flip(10.^((1:(mid))-1))');
        right(k) = (digits(mid+1:end)*flip(10.^((1:(mid))-1))');
    end
    out = [left, right];
end
