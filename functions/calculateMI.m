function mutualInformation = calculateMI(a, b)
%CALCULATEMUTUALINFORMATION Calculates mutual information between matrices a and b.

% Calculate the overlap region
[Ma, Na] = size(a);
[Mb, Nb] = size(b);
M = min(Ma, Mb);
N = min(Na, Nb);

% Initialize histogram arrays
hab = zeros(256, 256);
ha = zeros(1, 256);
hb = zeros(1, 256);

% Normalize matrices a and b
a = normalizeMatrix(a);
b = normalizeMatrix(b);

% Convert matrices to integer values for indexing
a = double(int16(a * 255)) + 1;
b = double(int16(b * 255)) + 1;

% Compute joint and individual histograms
for i = 1:M
    for j = 1:N
        indexA = a(i, j);
        indexB = b(i, j);
        hab(indexA, indexB) = hab(indexA, indexB) + 1; % Joint histogram
        ha(indexA) = ha(indexA) + 1; % Histogram for matrix a
        hb(indexB) = hb(indexB) + 1; % Histogram for matrix b
    end
end

% Calculate joint entropy (Hab)
jointEntropy = calculateEntropy(hab);

% Calculate individual entropies (Ha and Hb)
entropyA = calculateEntropy(ha);
entropyB = calculateEntropy(hb);

% Calculate mutual information using the formula
mutualInformation = 2 * (entropyA + entropyB - jointEntropy) / (entropyA + entropyB);

end

function entropy = calculateEntropy(histMatrix)
%CALCULATEENTROPY Calculates entropy from a histogram matrix.

% Flatten the matrix and remove zero values
histVector = histMatrix(:);
histVector(histVector == 0) = [];

% Normalize the histogram
probabilities = histVector / sum(histVector);

% Calculate entropy
entropy = -sum(probabilities .* log(probabilities + eps));

end

function normalizedMatrix = normalizeMatrix(matrix)
%NORMALIZEMATRIX Normalizes a matrix.

if max(matrix(:)) ~= min(matrix(:))
    normalizedMatrix = (matrix - min(matrix(:))) / (max(matrix(:)) - min(matrix(:)));
else
    normalizedMatrix = zeros(size(matrix));
end

end
