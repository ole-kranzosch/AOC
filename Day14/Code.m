clear; close all;
%% Read input
inp = readlines("Input14.txt");
inp = split(inp,'=');
x_0 = split(inp(:,2),' ');
x_0 = str2num(char(x_0(:,1))); %#ok<ST2NM>
v_0 = str2num(char(inp(:,end))); %#ok<ST2NM>
L_x1 = 101;  %Width
L_x2 = 103;   %Height

T = 100;

x = x_0 + v_0*T;
x(:,1) = mod(x(:,1),L_x1);
x(:,2) = mod(x(:,2),L_x2);

idx1 = x(x(:,1)<((L_x1-1)/2) & x(:,2)<((L_x2-1)/2),1);
idx2 = x(x(:,1)>((L_x1-1)/2) & x(:,2)<((L_x2-1)/2),1);
idx3 = x(x(:,1)>((L_x1-1)/2) & x(:,2)>((L_x2-1)/2),1);
idx4 = x(x(:,1)<((L_x1-1)/2) & x(:,2)>((L_x2-1)/2),1);

secrurity_factor = numel(idx1)* numel(idx2)* numel(idx3)* numel(idx4);
sprintf('%16.f',secrurity_factor)

%%%%%%% PART 2
x = x_0;
t = 0;
while true
    x = x + v_0;
    x(:,1) = mod(x(:,1),L_x1);
    x(:,2) = mod(x(:,2),L_x2);
    img = false(L_x1,L_x2);
    idx = sub2ind(size(img),x(:,1)+1,x(:,2)+1);
    img(idx) = true;
    t = t+1;    
    conn = bwconncomp(img,4);
    count = cellfun(@numel,conn.PixelIdxList);
    if any(count>40)
        disp(t)
        figure(1)
        imshow(img);
        pause;
        break
    end    
end
