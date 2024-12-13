clear; close all;
%% Read input
inp = readlines("Input13.txt");
inp(inp =="") = [];
inp = replace(inp,'=','+');
inp = split(inp,'+');
X = split(inp(:,2),',');
X = double(X(:,1));
Y = double(inp(:,end));

cost = 0;
for i = 1:length(inp)/3
    A = [X(3*i-2); Y(3*i-2)];
    B = [X(3*i-1); Y(3*i-1)];
    P = [X(3*i); Y(3*i)]+1e13;    %  Just add 1e13 here for PART 2
    M = [A B];
    presses = M\P;
    if all(round(presses) == round(presses,2))
        cost = cost + [3 1]*presses;
    end
end

sprintf('%16.f',cost)


