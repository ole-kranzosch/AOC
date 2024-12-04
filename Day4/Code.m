clear;
%% Read input
inp = readlines("Input4.txt");
%% Convert input to matrix
letters = {'X', 'M', 'A', 'S'};
for i=1:4
    inp = strrep(inp,letters{i},string(i));
end
num_inp = char(inp)-'0';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Build convolution kernels
multiplier = [0 0 0 1 10 100 1000];
plain_mat = zeros(7,7);
plain_mat(4,:) = multiplier;
diag_mat = diag(multiplier);
conv_kernels(:,:,1) = plain_mat;conv_kernels(:,:,2) = flip(diag_mat,1);conv_kernels(:,:,3) = flip(plain_mat',1);
conv_kernels(:,:,4) = flip(flip(diag_mat,1),2);conv_kernels(:,:,5) = flip(plain_mat,2);
conv_kernels(:,:,6) = flip(diag_mat,2);conv_kernels(:,:,7) = plain_mat';conv_kernels(:,:,8) = diag_mat;
%% Perform convolution
count = 0;
for i = 1:8
    conv_inp = conv2(num_inp,conv_kernels(:,:,i));
    count = count + sum(conv_inp == 4321,'all');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Build convolution kernels
multiplier2 = [10 100 1000];
diag_mat2 = diag(multiplier2);
conv_kernels2(:,:,1) = diag_mat2;conv_kernels2(:,:,2) = flip(diag_mat2,2);
%% Perform convolution
conv_inp1 = conv2(num_inp,conv_kernels2(:,:,1));
conv_inp2 = conv2(num_inp,conv_kernels2(:,:,2));
count2 = sum((conv_inp1 == 4320 | conv_inp1 == 2340) &  (conv_inp2 == 4320 | conv_inp2 == 2340),'all');