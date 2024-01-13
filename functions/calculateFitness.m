function [IE, MI] = calculateFitness(data_2D, sp_idx, N_sp)
%CALCULATEFITNESS Calculates fitness measures for each superpixel block.
%   [IE, MI] = CALCULATEFITNESS(DATA_2D, SP_IDX, N_SP) computes Information
%   Entropy (IE) and Mutual Information (MI) for each pre-defined superpixel block.

% Initialize cell arrays to store results
IE = cell(N_sp, 1);
MI = cell(N_sp, 1);

% Calculate IE and MI for each pre-defined superpixel block
for i = 1:N_sp
    % Extract data for the current superpixel block
    current_data = data_2D(sp_idx == i, :);

    % Calculate Information Entropy (IE) using 'calculateEntropy' function
    IE{i} = calculateEntropy(current_data');

    % Calculate Mutual Information (MI) using 'calculate_mutual_information_matrix' function
    MI{i} = calculate_mutual_information_matrix(current_data);
end

end
