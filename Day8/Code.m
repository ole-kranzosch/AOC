clear;
%% Read input
inp = readlines("Input8.txt");
inp_mat = char(inp) - '0';
inp_mat(inp_mat==-2) = NaN;
frequencies = unique(inp_mat(~isnan(inp_mat)));
antinodes = false(size(inp_mat));

for i = 1:numel(frequencies)
    [row,col] = find(inp_mat==frequencies(i));
    for k = 1:(numel(row)-1)
        for p = (k+1):numel(row)
            local_an = false(size(inp_mat));
            row_k = row(k);
            row_p = row(p);
            col_k = col(k);
            col_p = col(p);
            row_an = [2*row_k-row_p, 2*row_p-row_k];
            col_an = [2*col_k-col_p, 2*col_p-col_k];
            keep_idx = (row_an>0) & (col_an>0) & (row_an<=size(inp_mat,1)) & (col_an<=size(inp_mat,2));
            row_an = row_an(keep_idx);
            col_an = col_an(keep_idx);
            idx = sub2ind(size(local_an), row_an,col_an);
            local_an(idx) = true; 
            antinodes = antinodes | local_an;
        end
    end
end
an_sum = sum(antinodes,'all');
disp(an_sum)

%%%%% Part 2
antinodes = false(size(inp_mat));
for i = 1:numel(frequencies)
    [row,col] = find(inp_mat==frequencies(i));
    for k = 1:(numel(row)-1)
        for p = (k+1):numel(row)
            local_an = false(size(inp_mat));
            row_k = row(k);
            row_p = row(p);
            col_k = col(k);
            col_p = col(p);
            d_col = col_k-col_p;
            d_row = row_k-row_p;
            if d_row >0
                row_an1 = row_k:(row_k-row_p):size(inp_mat,1);
                row_an2 = row_p:(row_p-row_k):1;
            elseif d_row <0
                row_an1 = row_k:(row_k-row_p):1;
                row_an2 = row_p:(row_p-row_k):size(inp_mat,1);
            end
            if d_col >0
                col_an1 = col_k:(col_k-col_p):size(inp_mat,2);
                col_an2 = col_p:(col_p-col_k):1;
            elseif d_col <0
                col_an1 = col_k:(col_k-col_p):1;
                col_an2 = col_p:(col_p-col_k):size(inp_mat,2);
            else
                col_an1 = ones(1,numel(row_an1))*col_k;
                col_an2 = ones(1,numel(row_an2))*col_p;
            end
            if d_row == 0
                row_an1 = ones(1,numel(col_an1))*row_k;
                row_an2 = ones(1,numel(col_an2))*row_p;
            end
            len1 = min(numel(col_an1),numel(row_an1));
            len2 = min(numel(col_an2),numel(row_an2));
            row_an = [row_an1(1:len1), row_an2(1:len2)];
            col_an = [col_an1(1:len1), col_an2(1:len2)];
            idx = sub2ind(size(local_an), row_an,col_an);
            local_an(idx) = true; 
            antinodes = antinodes | local_an;
        end
    end
end
an_sum = sum(antinodes,'all');
disp(an_sum)