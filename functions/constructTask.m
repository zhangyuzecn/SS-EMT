function [data_2D, sp_idx, similarity_matrix] = constructTask(data, img_PCA, params)
%CONSTRUCTTASK Constructs a task by performing superpixel segmentation and clustering.
%   [DATA_2D, SP_IDX, SIMILARITY_MATRIX] = CONSTRUCTTASK(DATA, IMG_PCA, PARAMS)
%   performs superpixel segmentation, normalization, and computes a similarity
%   matrix for clustering.

% Extract parameters
N_sp = params.N_sp;

% Get dimensions of the data
[M, N, O] = size(data);

% Superpixel segmentation
SP_Map = superpixel_func(img_PCA, N_sp);

% Reshape data for 2D representation
data_2D = reshape(data, M * N, O);
data_2D = mapminmax(data_2D, 0, 1);

% Reshape superpixel indices
sp_idx = reshape(SP_Map, M * N, 1);

% Clustering for similar superpixel blocks
% Initialize similarity matrix
similarity_matrix = zeros(N_sp);

% Calculate similarity between superpixel blocks
for i = 1:N_sp
    % Data of the current superpixel block
    current_block = data_2D(sp_idx == i, :);
    
    for j = i + 1:N_sp
        % Other data of the superpixel block
        other_block = data_2D(sp_idx == j, :);

        % Calculate Euclidean distance
        distance = calculateMI(current_block, other_block);
        similarity_matrix(i, j) = distance;
        similarity_matrix(j, i) = distance;
    end
end


end
