function hx = calculateEntropy(X)
%CALCULATEENTROPY Calculates entropy for each row in the input matrix X.
%   HX = CALCULATEENTROPY(X) computes the entropy for each row of the input
%   matrix X and normalizes the values.

    G = 256;  % Number of bins for the histogram
    [L, N] = size(X);  % Dimensions of the input matrix
    rak_val = zeros(L, 1);  % Initialize array to store entropy values

    % Normalize the values in each row of X
    minX = min(X(:));
    maxX = max(X(:));
    edge = linspace(minX, maxX, G);  % Create edges for histogram bins

    % Calculate entropy for each row
    for i = 1 : L
        histX = hist(X(i, :), edge) / N;  % Compute histogram
        rak_val(i) = - histX * log(histX + eps)';  % Calculate entropy
    end

    % Sort entropy values in descending order
    [temp_rank, I] = sort(rak_val, 'descend');
    for i = 1 : L
        rak_val(I(i)) = temp_rank(i);
    end

    % Normalize the entropy values
    hx = rak_val';
    hx = (hx - min(hx)) / (max(hx) - min(hx));

end
