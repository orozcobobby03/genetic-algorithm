

% base = the base of the exponential (e, 2, 3, 4, etc; for r^2piif(k)/N, where r is any base)
% N = N in the power's denomenator and the nsteps
% f = function f(k)


% Function definition for plotting the exponential sum
function plot_exponential_sum(N, f)
     % Check if N is a positive integer
    if N <= 0 || N ~= floor(N)
        error('N must be a positive integer.');
    end
    
    S = zeros(N + 1, 1);  % Initialize array to store the sum, with one extra point

    % Prepare arrays for X and Y coordinates
    X = zeros(N + 1, 1);
    Y = zeros(N + 1, 1);
    Z = (0:N)';  % Use k from 0 to N

    % Compute the sum and store real and imaginary parts
    for k = 0:N-1
        S(k + 1) = exp(2 * pi * 1i * f(k) / N);  % Compute the exponential term
        X(k + 1) = real(S(k + 1));  % Real part
        Y(k + 1) = imag(S(k + 1));  % Imaginary part
    end
    
    % Include the Nth point, which is equal to the first point
    X(N + 1) = X(1);
    Y(N + 1) = Y(1);

    % Create the figure
    figure;
    
    % Create a 2D plot first
    plot(X, Y, 'LineWidth', 2, 'Color', 'b'); % Connect the points in 2D
    xlabel('Real Part');
    ylabel('Imaginary Part');
    title(['2D Visualization of Exponential Sum with f(k) = ', func2str(f)]);
    grid on;

    % Enable interactive features
    zoom on;
    pan on;
    
    % Create a button to toggle to 3D view
    uicontrol('Style', 'pushbutton', 'String', 'Switch to 3D View', ...
              'Position', [20 20 150 30], ...
              'Callback', @(src, event) plot_3d(X, Y, Z));

    hold off;  % Release the hold on the current figure
end

function plot_3d(X, Y, Z)
    % Create a new figure for the 3D plot
    figure;

    % Plot the connected points in 3D
    plot3(X, Y, Z, 'LineWidth', 2, 'Color', 'b'); % Connecting the points
    xlabel('Real Part');
    ylabel('Imaginary Part');
    zlabel('Index');
    title('3D Visualization of Exponential Sum');
    grid on;

    % Enable interactive features
    zoom on;
    pan on;
    
    hold off;  % Release the hold on the current figure
end
