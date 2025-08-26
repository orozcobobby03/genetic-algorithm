function sortP = sorted_P(P, F)

% Sort F and get sorting indices. This gives me two outputs.
% The first output gives me what F is actually sorted. The second output
% shows us where the sorted_F values are with respect to F.
%% E.g., ==================================================================
% A = 3x1 
%   2012
%   2063
%   1992
%
% [B,I] = sort(A)
%
% B = 3x1 datetime
%   1992
%   2012
%   2063
%
% I = 3×1
%
%     3
%     1
%     2
%% ========================================================================

[sorted_F, sorted_indices] = sort(F, 'descend');

% Sort matrix P according to the sorted indices of F
sortP = P(sorted_indices, :);

disp(sorted_F);
disp(sortP);
end