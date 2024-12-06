clear;
inp = readlines("Input6.txt");
marks = {'.','#','^'};
for i=1:3
    inp = strrep(inp,marks{i},string(i-1));
end
num_inp = char(inp)-'0';
guard_path = false(size(num_inp));
rotation = 2;
[i,j] = find(num_inp==rotation);
while true
    if rotation == 2
        path = num_inp(1:i,j);
        stop = find(flip(path)==1,1);
        if isempty(stop)
            walked_path = false(size(num_inp));
            walked_path(1:i,j) = true;
            guard_path = guard_path | walked_path;
            break
        end
        stop = i+2-stop;
        walked_path = false(size(num_inp));
        walked_path(stop:i,j) = true;
        i = stop;
        guard_path = guard_path | walked_path;
        rotation = 3;
    elseif rotation == 3
        path = num_inp(i,j:end);
        stop = find(path==1,1);
        if isempty(stop)
            walked_path = false(size(num_inp));
            walked_path(i,j:end) = true;
            guard_path = guard_path | walked_path;
            break
        end
        stop = j-2+stop;
        walked_path = false(size(num_inp));
        walked_path(i,j:stop) = true;
        j = stop;
        guard_path = guard_path | walked_path;
        rotation = 4;
    elseif rotation == 4
        path = num_inp(i:end,j);
        stop = find(path==1,1);
        if isempty(stop)
            walked_path = false(size(num_inp));
            walked_path(i:end,j) = true;
            guard_path = guard_path | walked_path;
            break
        end
        stop = i-2+stop;
        walked_path = false(size(num_inp));
        walked_path(i:stop,j) = true;
        i = stop;
        guard_path = guard_path | walked_path;
        rotation = 5;
    elseif rotation == 5
        path = num_inp(i,1:j);
        stop = find(flip(path)==1,1);
        if isempty(stop)
            walked_path = false(size(num_inp));
            walked_path(i,1:j) = true;
            guard_path = guard_path | walked_path;
            break
        end
        stop = j+2-stop;
        walked_path = false(size(num_inp));
        walked_path(i,stop:j) = true;
        j = stop;
        guard_path = guard_path | walked_path;
        rotation = 2;
    end
end
walked_spots = sum(guard_path,'all');
disp(walked_spots)
%%%%%%%%% PART 2
num_inp2 = num_inp;
guard_path(num_inp==2) = 0;
[path_row, path_col] = find(guard_path);
loop_obstacles = 0;
for k = 1:walked_spots-1
    guard_path = false(size(num_inp2));
    rotation = 2;
    num_inp = num_inp2;
    num_inp(path_row(k),path_col(k)) = 1;
    [i,j] = find(num_inp==rotation);
    
    iters = 1;
    while true
        if rotation == 2
            path = num_inp(1:i,j);
            stop = find(flip(path)==1,1);
            if isempty(stop)
                walked_path = false(size(num_inp));
                walked_path(1:i,j) = true;
                guard_path = guard_path | walked_path;
                break
            end
            stop = i+2-stop;
            walked_path = false(size(num_inp));
            walked_path(stop:i,j) = true;
            i = stop;
            rotation = 3;
        elseif rotation == 3
            path = num_inp(i,j:end);
            stop = find(path==1,1);
            if isempty(stop)
                walked_path = false(size(num_inp));
                walked_path(i,j:end) = true;
                guard_path = guard_path | walked_path;
                break
            end
            stop = j-2+stop;
            walked_path = false(size(num_inp));
            walked_path(i,j:stop) = true;
            j = stop;
            rotation = 4;
        elseif rotation == 4
            path = num_inp(i:end,j);
            stop = find(path==1,1);
            if isempty(stop)
                walked_path = false(size(num_inp));
                walked_path(i:end,j) = true;
                guard_path = guard_path | walked_path;
                break
            end
            stop = i-2+stop;
            walked_path = false(size(num_inp));
            walked_path(i:stop,j) = true;
            i = stop;
            rotation = 5;
        elseif rotation == 5
            path = num_inp(i,1:j);
            stop = find(flip(path)==1,1);
            if isempty(stop)
                walked_path = false(size(num_inp));
                walked_path(i,1:j) = true;
                guard_path = guard_path | walked_path;
                break
            end
            stop = j+2-stop;
            walked_path = false(size(num_inp));
            walked_path(i,stop:j) = true;
            j = stop;
            
            rotation = 2;
        end
        if all(guard_path == (guard_path | walked_path))
            iters = iters +1;
            if iters == sum(guard_path,'all')
                loop_obstacles = loop_obstacles +1;
            break
            end
        end
        guard_path = guard_path | walked_path;
    end
end
disp(loop_obstacles);