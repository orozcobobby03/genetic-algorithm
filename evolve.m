%% Before we run the function, we define these:
% n = #;
% base (N) = #;
% P = population(n, base);
% target_sum = -0.62348980185873353;
% [F, P] = fitness_loop(P, target_sum);
    % looking at F, we then look at the t to define:
 % t = #;
%% ========================================================================


% this function gives us:
    % P = this is the population (updated after loops through)
    % F = fitness vector (that has been looped and updated to match P)
    % E = evaluation (compare sum obtained to the target_sum)


    % P = population(n, base);
    % [F, P] = fitness_loop(P, target_sum);
    % t = #;

    % F1 = [] (if fitness F1 vector when P is matrix and not cell
        % we look at if it is an empty cell
function [P, F, E] = evolve(P, F, NewP, target_sum, b, m, t, d, numYrs)
    n = size(P, 1);
    for i = 1:numYrs   
        % Ensure t is at least 2
        t = max(2, t);

        number_of_births = round((b*size(P, 1))/100); % PAIRS pf births
        high_fitness_prob = 0.8;
        new_offspring = [];

        % Calculate the high fitness range and ensure it's at least 1
        high_fitness_range = max(1, round(t * high_fitness_prob));


        for j = 1:number_of_births
            if rand() < high_fitness_prob
                prandn1 = randi([1, high_fitness_range], 1, 1);
                prandn2 = randi([1, high_fitness_range], 1, 1);
                while prandn1 == prandn2
                    prandn2 = randi([1, high_fitness_range], 1, 1);
                end
            else
                prandn1 = randi([1, t], 1, 1);
                prandn2 = randi([1, t], 1, 1);
                while prandn1 == prandn2
                    prandn2 = randi([1, t], 1, 1);
                end
            end

        % Ensure valid range for l
        max_l = max(1, size(NewP, 2) - 1);
        l = randi([1, max_l], 1, 1);
    
        parent1_first_half = NewP(prandn1, 1:l);
        parent1_second_half = NewP(prandn1, l+1:end);

        parent2_first_half = NewP(prandn2, 1:l);
        parent2_second_half = NewP(prandn2, l+1:end);
    
        os1 = [parent1_first_half, parent2_second_half]; % offspring 1
        os2 = [parent2_first_half, parent1_second_half]; % offspring 2
        O = [os1; os2];
        O = mutate(O, m, size(O, 1));
        new_offspring = [new_offspring; O];
        end

        P = [P; new_offspring];

        [F1, P] = fitness_loop(P, target_sum);
        P = deaths(d, P, F1, n);
        [F, P] = fitness_loop(P, target_sum);


    % difference of the means of F & F1
    fitness_difference = mean(F) - mean(F1);

    F_Diff(i) = fitness_difference;
    F_Mean(i) = mean(F);
    % disp([F_Diff(i), F_Mean(i)]);
    end
   
[P, F, E] = evaluation(P, target_sum, F);
    end
% disp(E);