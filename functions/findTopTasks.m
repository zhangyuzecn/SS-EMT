function topTasks = findTopTasks(targetTaskIndex, taskMatrix)
    % FINDTOPTASKS Selects the top two tasks based on a given index and matrix.
    % 
    %   Inputs:
    %       targetTaskIndex  - Index of the target task.
    %       taskMatrix       - Matrix containing task values.
    %
    %   Output:
    %       topTasks - Indices of the top two tasks.

    % Sort the task values in descending order for the specified task index
    [sortedValues, sortedIndices] = sort(taskMatrix(targetTaskIndex, :), 'descend');
    
    % Select the top two tasks based on the sorted indices
    topTasks = sortedIndices(1:2);
end
