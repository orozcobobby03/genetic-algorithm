function constrained_F = con_fit(F)

    numRows = size(F, 1); % I replaced size(A, 1) with size(F, 1) since F 
                         % and A have the same number of rows. 

    % initializing the variable                     
    constrained_F = zeros(numRows, 1);
                     
    % We want to constrain the values to a certain range so that we can
    % know the significance of the fit_val .
    % Constrain fitness values to the range [0, 1]
    for i = 1:numRows
        if F(i) <= min(F)
            constrained_F(i) = min(F);
        elseif F(i) >= max(F)
            constrained_F(i) = max(F);
        else
            constrained_F(i) = F(i);
        end
    end

    % I have done this for min and max of F so that they are not restricted
    % to 0s and 1s since this may not be correct. 

    %% Should we even restrict the values to a range? 
    %% We look at the highest value anyway.

end