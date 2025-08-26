function [C] = cycleshift(P) 

C = []; % C is the matrix with the cycles

    C = [C; P(1, :)]; % the row with no cylces, or that has gone all the way around
                      % the "identity" cycle vector
N = size(P, 2);

    % this is N - 1 cylces. the Nth is the "identity" which is above
    for j = 1:N-1 % goes from the first to the second-to-last
        C1 = [P(1, ((end-j) + 1):end), P(1, 1:(end-j))]; 
             % P(1, (end-j) + 1:end) takes the last j elements and brings it to the front
             % P(1, 1:(end-j)) takes the first thru the second-to-last and moves it over the the right by one
      % What this does is it takes the original vector and moves j elements 
      % to the beginning for every j.
      % It takes one element to the front; looking at the original
      % vector again, it takes two; looking at the original vector
      % again, it takes three; etc. 
        C = [C; C1];
    end

   % Then I evaluate fitness. Yet, how exactly am I evaluating these? The
   % OG way?? With the sum or prod? 

