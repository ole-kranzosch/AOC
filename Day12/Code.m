clear; close all;
%% Read input
inp = char(readlines("Input12.txt"))-'0';
ker = [0,1,0;1,1,1;0,1,0];
plant_types = unique(inp);

cost = 0;
for i=1:numel(plant_types)
    conn = false(size(inp));
    conn(inp==plant_types(i)) = true;
    img = bwconncomp(conn,4);
    conn_pixels = img.PixelIdxList;
    for k = 1:size(conn_pixels,2)
        idx = conn_pixels{k};
        block = false(size(inp));
        block(idx) = true;
        area = sum(block,'all');
        conv_block = conv2(block,ker,'same');
        conv_block((~block) | (conv_block>5)) = 5;
        perim = abs(sum(conv_block-5,'all'));
        cost = cost + area*perim;
    end
end
sprintf('%16.f',cost)

%%%%% PART 2
cost = 0;
for i=1:numel(plant_types)
    conn = false(size(inp));
    conn(inp==plant_types(i)) = true;
    img = bwconncomp(conn,4);
    conn_pixels = img.PixelIdxList;
    for k = 1:size(conn_pixels,2)
        idx = conn_pixels{k};
        block = false(size(inp));
        block(idx) = true;
        area = sum(block,'all');
        ext_block = kron(block, ones(16));
        padded = false(size(ext_block)+32);
        padded(17:(end-16),17:(end-16)) = ext_block;
        [row, col] = find(padded);
        row_max = max(row) + 16;
        col_max = max(col) + 16;
        row_min = min(row) -16;
        col_min = min(col) -16;
        padded = padded(row_min:row_max, col_min:col_max);
        corners = detectHarrisFeatures(padded);
        perim = corners.Count + sum(corners.Metric > 0.1);
        cost = cost + area*perim;       
    end
end
sprintf('%16.f',cost)


