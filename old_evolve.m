%% Before we run the function, we define these:
% n = #;
% base (N) = #;
% P = population(n, base);
% target_sum = -0.62348980185873353;
% F = fitness_loop(P, target_sum);
    % looking at F, we then look at the t to define:
 % t = #;
%% ========================================================================


% this function gives us:
    % P = this is the population (updated after loops through)
    % F = fitness vector (that has been looped and updated to match P)
    % E = evaluation (compare sum obtained to the target_sum)

function [P, F, E] = old_evolve(P, F, target_sum, b, m, d, t, numYrs)

% reason I have percentages changing:
%% Goal: create a percentage that changes based on how close the means are 
    % E.g., If it is barely less than the mean, than it will drastically
    % change for a small interval (that does not need to change to
    % drastically). 

    
% Define (initial) percentage change
initial_percentage = 5; % 5% change


    for i = 1:numYrs
        P = births(b, P, F, t); % t = # of mates that will mate 
                                % (after fitness evaluation)
        P = mutate(P, m);
        F1 = fitness_loop(P, target_sum);
        P = deaths(d, P, F1);
        F = fitness_loop(P, target_sum);


% difference of the means of F & F1
fitness_difference = mean(F) - mean(F1); % abs() so that no negatives 
                                              % are present.
disp([fitness_difference, mean(F), -log(max(F))]);

%% Scale the percentage change based on the fitness difference
percentage = (initial_percentage)*(fitness_difference); 

        if mean(F) <= mean(F1)
            b = round(b - (b*percentage/100)); % new_b = old_b with a decrease by 
                                        % percentage (which is calculated by 
                                        % b*percent)
            d = round(d + (d*percentage/100)); % rounding to get integer
        elseif mean(F) > mean(F1)
            b = round(b + (b*percentage/100));
            d = round(d - (d*percentage/100));
%% if mean(F) <= mean(F1) :
% b decreases if the F values are getting worse (lower) OR remains the same 
    % -- we do not need births of those that have low values (fitness-wise).
% d inc. here because F values are getting worse, so we want less of them.
% m should be random?

%% if mean(F) > mean(F1) :
% b inc. since F values are getting better (higher in value) so we want
    % more of the high fitness.
% d is dec if F values are getting better since we want more of these types
    % of fitness levels. 
% m should be random?
        end
    
       % Conditions for b:
       if b >= 100
           b = 100;
       elseif b <= 0
           b = 0;
       end


       % Conditions for d:
       if d >= 100
           d = 100;
       elseif d <= 0
           d = 0;
       end

    end

   
[P, F, E] = evaluation(P, target_sum, F);

end