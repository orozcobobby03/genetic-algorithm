function P = deaths(d, P, F, n)

% after births(), I will input "ans" from the workspace as my "P" to plug
% into the function ( deaths(ans, 40), e.g.)

% P is the population matrix
% d = 40, e.g.    % death rate in percentage
% F = fitness values vector

number_of_deaths = 2*(round(n*(d/100))); % 2*() b/c births is in pairs


[sorted_F, sorted_indices] = sort(F, 'descend');
    % Reorder P based on sorted fitness indices
    P = P(sorted_indices, :);

    % Select top n organisms (higher fitness individuals survive)
    P = P(1:n, :);

end