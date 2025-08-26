%% Mutations
function P = mutate(P, m, K) % There is not output for this... P matrix will change on its own. 
number_of_mutations = round(K*(m/100));

% since we have births() and it needs to be called before mutate(), we can
% set the birth rate to be 0% in the function. 
% Also, note that this is due to the fact that mutations can happen later
% in life too. Finally, I would have had to change the Y in populations to
% A, but this would mess everything up in all my functions. This is why I
% can set my birth rate to 0%, and I get a 20x20 population without births.

    for k = 1:number_of_mutations
        y = randi([1, size(P, 1)], 1, 1); % picking a random row
        w = randi([1, size(P, 2)], 1, 1); % picking a random column
    
        if P(y, w) == 1
        P(y, w) = 0;
        elseif P(y, w) == 0
        P(y, w) = 1;
        end
    end
end