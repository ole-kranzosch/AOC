%% Day 2 AOC
clear; close all;
%% Read input
Df = readlines("Input2.txt");
N = 0;
for i = 1:length(Df)
    rep = str2double(split(Df(i)));
    d_rep = diff(rep);
    if all(d_rep<=3 & d_rep>0) | all(d_rep<0 & d_rep>=-3)
        N = N +1;
    else
        for k=1:length(rep)
            rrep = rep;
            rrep(k) = [];
            d_rrep = diff(rrep);
            if all(d_rrep<=3 & d_rrep>0) | all(d_rrep<0 & d_rrep>=-3)
                N = N +1;
                break
            end
        end
    end
end
%% Print answer
fprintf("Number of safe reports is: " + string(N) + "\n")

