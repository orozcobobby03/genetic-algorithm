function P = births(b, m, P, F, t)

    % Ensure t is within the bounds of P's number of rows (having trouble
    % on with NewP about not indexing correctly)  

% since sort went from least to greatest, i had to work backward in a sense

% sorted_P.m
% [~, sorted_indices] = sort(F, 'descend');

% Sort matrix P according to the sorted indices of F
% P = P(sorted_indices, :);
% this is a P that has been sorted
% (Above: P = sortP; )

% b = birth rate (in percentage)
% P = population matrix (0s and 1s)
% F = fitness values of P vector
% t = number of top individuals for reproduciton!
    % number of parents that will mate with each other (how ever many you
        % want to be evaluated based on the fitness values of F

% New Population that has the t rows
% NewP = P from 1 to t. (withOUT t+1:end)
    if t < 2
        t = 2;  % Minimum of 2 for valid crossover
    elseif t > size(P, 1)
        t = size(P, 1);  % Adjust t to be within the bounds of P
    end

NewP = P(1:t, :); % this is an t x base matrix 


% n = population size of NewP (columns)
% n = size(NewP, 2);

% this birth rate regards every single birth (i.e., accurate to the number)
% E.g., 30% adds 6 to the population.... w/o the division of 2, it causes: 
% 30% to add 12 since we are creating two offspring per pairs of parents

number_of_births = round((b*size(P, 1))/100);


% I was having trouble because the row size was changing when adding more
% offspring, so I had to define it to keep it the same.
% rsNewP = size(NewP, 1); % row size of NewP (this is literally "t")
% t = rsNewP; = t rows ((number of top individuals for reproduciton))

% Probability for high fitness selection (prob for high fits to mate with
                                                % each other).
high_fitness_prob = 0.8; % adjust to liking as desired

% Initialize a list for new offspring
new_offspring = [];


%% Looping the births
for i = 1:number_of_births
    % Higher probability for high fitness individuals to mate
    if rand() < high_fitness_prob % rand() generates random number btwn 0 & 1
        % (Above) This is for when that random number between 0 and 1 is 
                % < 80% (or > 20% --- more probability). 
        % Select high fitness parents
            % Creating a random integer between 1 and a number which is  
            % the number of rows multiplied by the high fit probability.
                % Rounding is to make it a whole number. 
        prandn1 = randi([1, round(t * high_fitness_prob)], 1, 1); % Random index from top high_fitness_prob proportion
        prandn2 = randi([1, round(t * high_fitness_prob)], 1, 1); % Random index from top high_fitness_prob proportion
    else
        % (Below) This is for when that random number between 0 and 1 is 
                % > 80% (or < 20% --- less probability). 
                % "Less probability" is for the high fit and the low fit
                % possibly mating with one another. 
        % Select any parents randomly
        prandn1 = randi([1, t], 1, 1); % Random index from all individuals
        prandn2 = randi([1, t], 1, 1); % Random index from all individuals
    end

    %{
    % Ensure prandn1 and prandn2 are not the same
    while prandn1 == prandn2
        prandn2 = randi([1, t], 1, 1);
    end 
    %}
    % Create offspring with these parents
    l = randi([1, size(NewP, 2) - 1], 1, 1); % "-1" ensure l is within valid 
                                          % range since it was giving me 
                                          % problems without "-1"

    parent1_first_half = NewP(prandn1, 1:l);
    parent1_second_half = NewP(prandn1, l+1:end);

    parent2_first_half = NewP(prandn2, 1:l);
    parent2_second_half = NewP(prandn2, l+1:end);

    os1 = [parent1_first_half, parent2_second_half]; % offspring 1
    os2 = [parent2_first_half, parent1_second_half]; % offspring 2

    O = [os1; os2];
    O = mutate(O, m);
    new_offspring = [new_offspring; O];
end

    % Adding offspring to the population
    P = [P; new_offspring]; % we do this for the death funciton ( P(1:end-t, :) )
                                    % Reducing P based on death rate should
                                    % adjust the size of P

end
