function [P, F, E] = evaluation(P, target_sum, F) % evaluation function
% function that compares the sum value to the correct solution (target_sum)
% P is the population with any changes (or none) that have taken place
% N = the term in the denominator of the exponential sums (col size of P)
% F is the vector with the fitness values for each "person" in the
% population.
    N = size(P, 2); % base
    [~, j] = max(F); % highest value regarding fitness
    x = P(j, :); % giving me back the bits (0s and 1s)
    k = 0:N-1; % these are nsteps, or 1:length(x)
    estimated_sum = sum(exp(2*1i*pi*k/N).*x); % multiplied out it gives me 
                                              % factors of 0s and 1s in front
    
    E = [estimated_sum, target_sum]; % comparing these values

end