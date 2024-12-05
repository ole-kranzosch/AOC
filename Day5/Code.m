clear;
%% Read input
inp = readlines("Input5.txt");
split_idx = find(inp == "", 1);
rules = inp(1:split_idx-1);
updates = inp(split_idx+1:end);
rules = double(split(strrep(rules,'|',' ')));

%% Check updates
correct_updates = 0;
incorrect_updates = 0;
for i = 1:numel(updates)
    update = double(split(strrep(updates(i),',',' ')));
    idx_X = false(size(rules,1),1);
    idx_Y = false(size(rules,1),1);
    % Create correct update
    for n = 1:numel(update)
        idx_X = idx_X | (rules(:,1) == update(n));
        idx_Y = idx_Y | (rules(:,2) == update(n));
    end
    idx = idx_X & idx_Y;
    X_Y = rules(idx,:);
    [GCC_X, GCN_X] = groupcounts(sort(X_Y(:,1)));
    [GCC_Y, GCN_Y] = groupcounts(sort(X_Y(:,2)));
    numbers = unique([GCN_X; GCN_Y]);
    power = zeros(size(numbers));
    for k = 1:numel(numbers)
        if isempty(GCC_X(GCN_X==numbers(k)))
            gain = 0;
        else
            gain = GCC_X(GCN_X==numbers(k));
        end
        if isempty(GCC_Y(GCN_Y==numbers(k)))
            loss = 0;
        else
            loss = GCC_Y(GCN_Y==numbers(k));
        end
        power(k) = gain - loss;
    end
    [power,idx]=sort(power,'descend');
    numbers=numbers(idx);
    [val, pos] = intersect(numbers,update);
    correct_numbers = numbers(sort(pos));
    %Check if update is correct
    if all(correct_numbers == update)
        correct_updates = correct_updates + update(ceil(numel(update)/2));
    else
        incorrect_updates = incorrect_updates + correct_numbers(ceil(numel(update)/2));
    end
end
disp(correct_updates);
disp(incorrect_updates);