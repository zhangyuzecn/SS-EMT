% Function to get the global best solution and corresponding fitness value
function [global_best_solution, best_fitness_value] = getGlobalBestParticle(x_subpopulation, IE, MI, D)
    % Get the number of particles in the subpopulation
    num_particles = size(x_subpopulation, 1);

    % Initialize an array to store fitness values for each particle
    fitness_values = zeros(num_particles, 2);

    % Calculate fitness values for each particle in the subpopulation
    for i = 1:num_particles
        fitness_values(i, :) = fitness(x_subpopulation(i, :), IE, MI, D);
    end

    % Transform fitness values using sigmoid activation
    f1 = 1 ./ (1.0 + exp(-1.0 * fitness_values(:, 1)));
    f2 = 1 ./ (1.0 + exp(-1.0 * fitness_values(:, 2)));

    % Combine transformed fitness values
    combined_fitness = f1 .* f2;

    % Find the index of the particle with the minimum combined fitness
    [~, index] = min(combined_fitness);

    % Get the global best solution and its corresponding fitness value
    global_best_solution = x_subpopulation(index, :);
    best_fitness_value = fitness_values(index, :);
end
