function [F, P] = fitness_loop(P, target_sum)
%% This takes in a MATRIX

% P = population matrix
    numRows = size(P, 1); % Number of rows to evaluate
    F = zeros(numRows, 1); % Initialize an array to store fitness values
    N = size(P, 2);

    for i = 1:numRows
        x = P(i, :); % Get the ith row of P (in 0s and 1s)
        F(i) = fitness(x, target_sum, N);
    end
    
    [F, sorted_indices] = sort(F, 'descend');
    P = P(sorted_indices, :); % Sort P accordingly

end