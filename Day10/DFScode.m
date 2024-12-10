clear;
%% Read input
inp = readlines("Input10.txt");
inp_mat = char(inp) - '0';
N_nodes = numel(inp_mat);

[Nrow,Ncol] = size(inp_mat);
%%% conv ker
dx_p = [0 0 0; 1 -1 0; 0 0 0];
dx_n = [0 0 0; 0 -1 1; 0 0 0];
dy_p = [0 0 0; 0 -1 0; 0 1 0];
dy_n = [0 1 0; 0 -1 0; 0 0 0];

Dx_p = conv2(inp_mat,dx_p,'same');
Dx_n = conv2(inp_mat,dx_n,'same');
Dy_p = conv2(inp_mat,dy_p,'same');
Dy_n = conv2(inp_mat,dy_n,'same');
Dx_p(Dx_p ~= 1) = 0;
Dx_n(Dx_n ~= 1) = 0;
Dy_p(Dy_p ~= 1) = 0;
Dy_n(Dy_n ~= 1) = 0;
valid_step = zeros(Nrow,Ncol,4);
valid_step(:,:,1) = Dx_p;
valid_step(:,:,2) = Dx_n;
valid_step(:,:,3) = Dy_p;
valid_step(:,:,4) = Dy_n;

%% Build Graph
s = [];
t = [];
for i = 1:N_nodes
    col = ceil(i/Nrow);
    row = i - Nrow*(col-1);
    validity = valid_step(row,col,:);
    t_local = [];
    for k = 1:4
        if validity(:,:,k) == 1
            if k == 1
                t_local = [t_local, i+Nrow];
            elseif k == 2
                t_local = [t_local, i-Nrow];
            elseif k == 3
                t_local = [t_local, i-1];
            elseif k == 4
                t_local = [t_local, i+1];
            end
        end
    end
    s = [s, ones(size(t_local))*i];
    t = [t, t_local];
end
g = digraph(s,t);
start_nodes = find(inp_mat==0);
N = numel(start_nodes);
trailhead_sum = 0;
for i=1:N
    connect_nodes = dfsearch(g,start_nodes(i));
    trailhead = sum(inp_mat(connect_nodes)==9);
    trailhead_sum = trailhead_sum + trailhead;
end
disp(trailhead_sum)

%%% PART 2
end_nodes = find(inp_mat==9);
M = numel(end_nodes);
trailhead_sum = 0;
for i=1:N
    for j = 1:M
        paths = allpaths(g,start_nodes(i),end_nodes(j));
        trailhead = size(paths,1);
        trailhead_sum = trailhead_sum + trailhead;
    end
end
disp(trailhead_sum)