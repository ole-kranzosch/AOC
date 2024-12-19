clear; close all;
%% Read input
inp = readmatrix('Input18.txt')+2;
bytes = 2959;
N = 70+3;
start = N+2;
goal = N^2-N-1;
grid = false(N);
grid(2:end-1,2:end-1) = true;
idx = sub2ind(size(grid),inp(1:bytes,2),inp(1:bytes,1));
log_idx = false(N);
log_idx(idx) = true;
grid(log_idx) = false;
nodes = find(grid==1);
s = [];
t = [];
w = [];
 
for i=1:numel(nodes)
    current_node = nodes(i);
    neighbours = false(N);
    idx = [current_node-1, current_node+1, current_node+N, current_node-N];
    neighbours(idx) = true;
    t_local = find(neighbours & grid);
    t = [t; t_local];
    s = [s; ones(size(t_local))*current_node];
end

full_graph = digraph(s',t');
[path, dist] = shortestpath(full_graph,start,goal);
sprintf('%16.f', dist)
