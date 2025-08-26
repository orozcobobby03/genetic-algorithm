function [F, P] = fitness_loop_bits(P, target_sum)
%% This takes in a MATRIX

%% This is for when the target_sum is a vector or bits 

% P = population matrix
    numRows = size(P, 1); % Number of rows to evaluate
    F = zeros(numRows, 1); % Initialize an array to store fitness values
    N = size(P, 2);
%   x = P(i, :); % Get the ith row of P (in 0s and 1s)

    for i = 1:numRows
        % initialize my count
        count = 0; % this counts how many are correct in per row... t
                   % this is in this for loop of i so that it restarts 
                   % the count every row
        for j = 1:N
            if P(i, j) == target_sum(j) % target_sum is a one row array
                count = count + 1;
            elseif P(i, j) ~= target_sum(j)
                count = count;
            end
        fit_val = count; % My fit_val is the number of correct spots that
                         % my guess & my target_sum (array) have in common.
        F(i) = fit_val;
    end
    
    [F, sorted_indices] = sort(F, 'descend');
    P = P(sorted_indices, :); % Sort P accordingly

end