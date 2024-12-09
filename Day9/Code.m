clear;
%% Read input
inp = readlines("Input9.txt");
inp_mat = char(inp) - '0';
N = sum(inp_mat);
IDs = numel(inp_mat);
expanded_disk = NaN(1,N); %init DISK
idx = 1;
for i = 1:IDs
    ID = (i-1)/2;
    entry = inp_mat(i);
    if mod(i,2) ~= 0
        expanded_disk(idx:idx+entry-1) = ID;
    end
    idx = idx + entry;
end
empty_idx = isnan(expanded_disk);
files = expanded_disk(~empty_idx);
compressed_size = numel(files);
slots = sum(isnan(expanded_disk(1:compressed_size)));
compressed_disk = expanded_disk(1:compressed_size);
overhang = expanded_disk(compressed_size+1:end);
compressed_disk(isnan(expanded_disk(1:compressed_size))) = flip(overhang(~isnan(overhang)));
checksum = compressed_disk*((1:compressed_size)'-1);
sprintf('%16.f',checksum)
%%%%%%% Part 2
free_space_sizes = inp_mat(2:2:end);
IDs = flip(1:((IDs+1)/2))-1;
for i = 1:numel(IDs)
    ID = IDs(i);
    file_block = expanded_disk(expanded_disk==ID);
    valid_space = find(free_space_sizes(1:ID)>=numel(file_block),1);
    if ~isempty(valid_space)
        no_nans = sum(free_space_sizes(1:(valid_space-1)))+1;
        idx = find(isnan(expanded_disk),no_nans);
        idx = idx(end);
        expanded_disk(expanded_disk==ID) = NaN;
        expanded_disk(idx:(idx+numel(file_block)-1)) = file_block;
        free_space_sizes(valid_space) = free_space_sizes(valid_space) - numel(file_block);
    end
end
disk = expanded_disk;
disk(isnan(disk)) = 0;
checksum = disk*((1:numel(disk))'-1);
sprintf('%16.f',checksum)