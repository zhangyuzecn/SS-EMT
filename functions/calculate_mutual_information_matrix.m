function mutual_information_matrix = calculate_mutual_information_matrix(data)
    % Calculate the mutual information matrix for a given dataset.

    % Get the number of features (columns) in the data.
    [~, num_features] = size(data);

    % Initialize the mutual information matrix with zeros.
    mutual_information_matrix = zeros(num_features, num_features);

    % Iterate over each pair of features and calculate mutual information.
    for i = 1:num_features
        for j = 1:num_features
            % Calculate mutual information between feature i and feature j.
            mutual_information_matrix(i, j) = calculateMI(data(:, i), data(:, j));
        end
    end
end
