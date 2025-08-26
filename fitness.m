function fit_val = fitness(x, target_sum, N)
%% THIS only takes in VECTORS, not MATRICES (fitness_loop.m does)

% After creating a population, we can evaluate per row.

%% =========================================================================
% rowNum = row number     (1 through 20 or the end of the population)
    % rowNum will be an integer, e.g., 5.
% x = A(rowNum, :)
%% =========================================================================

% target_sum = -0.62348980185873353


% N = the term in the denominator of the exponential sums
% N = length(x);

    % Compute the exponential sum for binary sequence x
    
    k = 0:N-1; % positions (indices/indexes)
    S = sum(exp(2*pi*1i*k/N).*x); % since x is an array of 0s and 1s we use ".*"
        % we mutilply it inside of the sum so that the terms are then sent out.
        % E.g., we get the 0 times the first term, 1 times the second term, and
        % so on. 
    
    Ws = zeros(1, N);
    for j = 1:N
        % W = abs(target_sum - S))^2;
        Ws(j) = abs(target_sum - S*(exp(2*pi*1i*j/N)))^2;
    end
  
    % W = symprod((abs(target_sum - S))^2, l, 0, N-1);

    W = min(Ws); % smaller W = less error = big fit vals
    % in my poster, the max over the js is the same as the e^-min since min
    % = -max
 
    fit_val = exp(-W); % fitness value

end

