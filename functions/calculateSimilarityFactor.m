function similarityFactor = calculateSimilarityFactor(spatialLabels, dataMatrix, numSp)

    % Initialize matrix to store pairwise similarity factor values
    similarityFactor = zeros(numSp, numSp);

    % Loop through spatial labels
    for i = 1:numSp
        % Find indices where spatial label is equal to i
        spIndexI = find(spatialLabels == i);
        
        % Extract sub-data for spatial label i
        dataSubI = dataMatrix(spIndexI, :); % Sub-data

        % Nested loop for pairwise comparisons
        for j = 1:numSp
            % Skip self-comparisons
            if j ~= i
                % Find indices where spatial label is equal to j
                spIndexJ = find(spatialLabels == j);

                % Extract sub-data for spatial label j
                dataSubJ = dataMatrix(spIndexJ, :); % Sub-data

                % Calculate similarity factor and store in the matrix
                similarityFactor(i, j) = calculateMI(dataSubI, dataSubJ);
            end
        end
    end

end
