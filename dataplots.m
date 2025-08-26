function [] = dataplots(n, N, b, m, t, d, num_target_sums, numYrs)
    % n is the number of rows in the populations
    % N is the number of cols in the populations
    % b, m, and d are the birth, mutation, and death rates, respectfully
    % num_target_sums are the number of target_sums there will be (i.e.,
        % the number of experiments there will be)
    % numYrs is the number of years that will be used in the evolve function
        % this is the amount of times it loops


    TsM = zeros(num_target_sums, 1); % target_sum column vector ("target_sum Matrix")
    
    P = cell(1, num_target_sums); % This "cell" can store numbers, vectors, matrices, and strings of words. 
                                  % P{1} is the first popuation matrix
                                  % corresponded with the first
                                  % target_sum vector in the TsM. This
                                  % applies for all elements in q (defined below). 

                                  % We are simply creating a space where
                                  % these population matrices will be
                                  % stored. For now they are empty. 

    NewP = cell(1, num_target_sums);

    %F = cell(num_target_sums, 1);
    %F1 = cell(num_target_sums, 1);

    for q = 1:num_target_sums % number of loops (repeats)
        k = 0:N-1; % index for sum
        p = population(1, N); % this generates a vector that will help with defining a target_sum
        target_sum = sum(exp(2*1i*pi*k/N).*p);
        TsM(q) = target_sum;

        P{q} = population(n, N); % the {q} is for the cell of P is for every q (as it loops)
        [F, P{q}] = fitness_loop(P{q}, TsM(q));
        
        if t < 2
            t = 2;  % Minimum of 2 for valid crossover
        else
            t = t;
        end

        NewP{q} = P{1, q}(1:t, :);

        % Initialize arrays to store fitness values for this experiment
        maxfit_vals{q} = zeros(numYrs, 1);
        minfit_vals{q} = zeros(numYrs, 1);

        % Evolve the population over the specified number of years
        for year = 1:numYrs
            % this evolve funtion goes for 1 year. this makes it easier to
            % loop this for a certain number of years. This is still the
            % same as have a evolve funtion for a number of years. 
            
            [P{q}, F, ~] = evolve(P{q}, F, NewP{q}, TsM(q), b, m, t, d, 1);
    
            % Record maximum and minimum fitness values
            maxfit_vals{q}(year) = max(F);
            minfit_vals{q}(year) = min(F);
        end
    
    end

    avg_maxfit_vals = zeros(1, numYrs);
    avg_minfit_vals = zeros(1, numYrs);

    for r = 1:numYrs
        for mu = 1:num_target_sums
            % Compute the average max fitness values for each year
            avg_minfit_vals(r) = mean(minfit_vals{mu}(r));
            avg_maxfit_vals(r) = mean(maxfit_vals{mu}(r));
        end
    end
           
    % Plot the averaged maximum fitness values over the years
    figure;
    set(gca, 'YScale', 'log');
    plot(1:numYrs, avg_minfit_vals, 'ro-', 'LineWidth', 1.5);
    hold on
    plot(1:numYrs, avg_maxfit_vals, 'b-d', 'LineWidth', 1.5);
    title('Average Min & Max Fitness Evolution Over Time');
    xlabel('Year');
    ylabel('Average Max & Min Fitness Values');
    legend('Average Min Fitness', 'Average Max Fitness');
    

    % NOTE about F:
        % F could be a cell, but this makes things harder to re-code. F
        % still loops through all the populations, but if you disp(F);, you
        % can see all the different F vectors there are. Finally, if you
        % look at F in the MATLAB Workspace, the F that is shown, is the
        % last P{q,1} population cell. 

    % Don't wnat figures to pop up (e.g., like 100 of them . . . just want one)
%{
        % Plots
        figure;
        hold on;
        plot(1:numYrs, maxfit_vals{q}, 'r-', 'DisplayName', sprintf('Max Fitness for Target %d', q)); 
            % q is here so that as it loops, the number of the figure 
            % matches with the loop (current q). 
        plot(1:numYrs, minfit_vals{q}, 'b--', 'DisplayName', sprintf('Min Fitness for Target %d', q));
        hold off;
        title(sprintf('Fitness Evolution for Target Sum %d', q));
        xlabel('Year');
        ylabel('Fitness Value');
        legend; 
%}
       

end