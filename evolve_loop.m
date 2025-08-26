function E1 = evolve_loop(P, F, target_sum, b, m, d, t, numYrs, loop)
    % Initialize arrays to store real and imaginary parts of E
    realE = zeros(1, loop);
    imagE = zeros(1, loop);

    % Set up the plot
    figure;
    grid on;
    xlabel('Real(E)');
    ylabel('Imag(E)');
    title('How E changes per loop')
    hold on; % Retain the plot for multiple iterations

    for q = 1:loop
        % Call the evolve function
        [P, F, E, F_Diff, F_Mean] = evolve(P, F, target_sum, b, m, t, d, numYrs);
        
        % Store the real and imaginary parts of E(1)
        realE(q) = real(E(1));
        imagE(q) = imag(E(1));
    end

    % Plot all points and connect them with lines
    plot(realE, imagE, 'o-'); % Use 'o-' to plot points and connect them with lines

    hold off; % Release the hold on the plot
end
