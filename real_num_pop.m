function [P] = real_num_pop(n, base)

% this is a function that creates a population matrix n x base (n
% individuals who have "DNA information" that is base long (written in 0s & 1s). 

    for i = 1:n
        v1 = round(rand(1, 1));
        if mod(base, 2) == 1
            j = (base - 1)/2;
            v2 = round(rand(1, j));
            v3 = [];
        elseif mod(base, 2) == 0
            j = (base - 2)/2;
            v2 = round(rand(1, j));
            v3 = 0;
        end
        P(i, :) = [v1, v2, v3, fliplr(v2)];
    end    
    
end