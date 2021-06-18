line = [ 1 2 2 2 NaN ];
buffer = 15; % max disparity
result = line;

% from the the left

for i = 1:5
    c = line(i); 
    if isnan(c)
        c = buffer;
    else
        buffer = c;
    end
    
    result(i)=c;    
end



%change if/else to logical indexing

line = [ 1 2 2 2 NaN; 2 NaN 4 4 4 ];

buffer= ones(1,5)*15;
result_left = line;

for i = 1:5
    c = line(:,i)    ;    
    c(isnan(c)) = buffer(isnan(c));
    buffer(~isnan(c)) = c(~isnan(c));
    result_left(:,i) = c;
end

result_left


% from the right
buffer= ones(1,5)*15;
result_right = line;

for i = 5:5
    c = line(:,i);     
    c(isnan(c)) = buffer(isnan(c));
    buffer(~isnan(c)) = c(~isnan(c))
    result_right(:,i) = c;
end

result_right