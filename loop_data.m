function [] = loop_data(n, b, m, t, d, num_target_sums, numYrs, lowerbound, upperbound)
    for f = lowerbound:upperbound
        for g = n-2:n+2
            dataplots(g, f, b, m, t, d, num_target_sums, numYrs);
        end
    end
end

% lowerbound is a number below the N. The upperbound is the number above
% the N. 

% E.g., if N = 100, i can choose to see the average max. fitness values for
% N = 95 to N = 105. So, my LB = 95, and my UB = 105. 