%% Day 1 AOC
clear; close all;
%% Read input
Df = readmatrix("Input1.txt");

%% Calculate answer
Df = sort(Df,1);
ID1 = Df(:,1);
ID2 = Df(:,2);
dist = sum(abs(ID1-ID2));

% task 2
[GC1,GR1] = groupcounts(ID1);
[GC2,GR2] = groupcounts(ID2);
idx = ismember(GR2, GR1);
clean_GC2 = GC2(idx);
clean_GR2 = GR2(idx);

sim_score = clean_GC2'*clean_GR2;


%% Print answer
fprintf("Total distance is: " + string(dist) + "\n")
fprintf("Similarity score is: " + string(sim_score) + "\n")
