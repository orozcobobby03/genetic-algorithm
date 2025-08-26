function visualize_exp_sum_for_multiple_N(max_N, f)
    % Function to visualize the exponential sums of a given function f(k)
    % for different values of N in both 2D and 3D.

    N_values = 1:max_N;  % Create an array of N values from 1 to max_N
    colors = lines(length(N_values));  % Generate distinct colors for plotting

    % Prepare storage for plot data
    all_X = cell(length(N_values), 1);  % Cell array to store X coordinates
    all_Y = cell(length(N_values), 1);  % Cell array to store Y coordinates
    
    % Create a figure for the 2D plot
    figure;
    hold on;  % Hold on to add multiple plots
    grid on;  % Turn on the grid for better visibility

    % Loop over different N values
    for idx = 1:length(N_values)
        current_N = N_values(idx);  % Current value of N
        S = zeros(current_N, 1);    % Initialize the complex sum array
        X = zeros(current_N, 1);     % Initialize the real part array
        Y = zeros(current_N, 1);     % Initialize the imaginary part array

        % Compute the exponential sum for the given function
        for k = 1:current_N
            func_value = f(k);  % Evaluate the function at k
            S(k) = exp(2 * pi * 1i * func_value / current_N);  % Calculate the exponential sum
            X(k) = real(S(k));  % Extract the real part
            Y(k) = imag(S(k));  % Extract the imaginary part
        end

        % Close the shape by adding the first point to the end
        X = [X; X(1)];  % Append the first point to the end of X
        Y = [Y; Y(1)];  % Append the first point to the end of Y

        % Store data for later use
        all_X{idx} = X;  % Store X coordinates
        all_Y{idx} = Y;  % Store Y coordinates

        % Plot the current line in 2D
        plot(X, Y, 'LineWidth', 2, 'Color', colors(idx, :));  
        plot(X, Y, 'o', 'Color', colors(idx, :), 'MarkerFaceColor', colors(idx, :));  % Mark points
    end

    % Finalize 2D plot
    xlabel('Real Part');  % Label for the X-axis
    ylabel('Imaginary Part');  % Label for the Y-axis
    title('2D Exponential Sum for Various N');  % Title of the plot
    axis equal;   % Ensure equal scaling for x and y axes
    hold off;     % Release the hold on the current figure

    % Create a button to toggle to 3D view
    uicontrol('Style', 'pushbutton', 'String', 'Switch to 3D View', ...
              'Position', [20 20 150 30], ...  % Position of the button
              'Callback', @(src, event) plot_3d(all_X, all_Y, N_values, colors));  % Callback function for button
end

function plot_3d(all_X, all_Y, N_values, colors)
    % Function to create a 3D plot of the exponential sums

    % Create a new figure for the 3D plot
    figure;
    hold on;  % Hold on to add multiple plots
    grid on;  % Turn on the grid for better visibility

    % Loop over different N values for the 3D plot
    for idx = 1:length(N_values)
        X = all_X{idx};  % Retrieve X coordinates for current N
        Y = all_Y{idx};  % Retrieve Y coordinates for current N
        current_N = N_values(idx);  % Current value of N
        Z = idx * ones(size(X));  % Z values based on the index (constant for each N)

        % Plot the current line in 3D
        plot3(X, Y, Z(1:current_N), 'LineWidth', 2, 'Color', colors(idx, :), 'LineStyle', '-');
    end

    % Finalize 3D plot
    xlabel('Real Part');  % Label for the X-axis
    ylabel('Imaginary Part');  % Label for the Y-axis
    zlabel('Index (k)');  % Label for the Z-axis
    title('3D Exponential Sum');  % Title of the plot
    view(3);   % Set the view to 3D

    hold off;  % Release the hold on the current figure
end
