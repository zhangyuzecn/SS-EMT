function [data_2D, sp_2D, gbest, N_sp] = SS_EMT(data, img_PCA, params)
    %% Parameters for data
    N_m = params.N_m;    % Number of objective functions
    N_sp = params.N_sp;  % Number of subgroups
    N_ind = params.N_sp; % Number of individuals in a subgroup
    GX = params.GX;      % Number of generations
    N_bands = size(data, 3); % Total number of bands
    D = params.D;
    rmp = params.rmp;    % Rand migration probability 
    sp_2D = params.sp_2D;
    C = params.C;
    %% Population initialization
    N_pop = N_sp * N_ind; % Total individuals in the population
    x = rand(N_pop, N_bands);
    v = 0.5 * rand(N_pop, N_bands);

    % Velocity control
    vmax = 0.5;
    vmin = -vmax;

    pbest = x; % Personal best solutions
    gbest = zeros(N_sp, N_bands);
    fv_gbest = zeros(N_sp, N_m);

    %% Data processing
    [M, N, ~] = size(data);
    data_2D = reshape(data, M * N, N_bands);
    data_2D = mapminmax(data_2D, 0, 1);

    for i = 1:N_sp
        IE = params.IE{i};
        MI = params.MI{i};
        [gbest(i, :), fv_gbest(i, :)] = getGlobalBestParticle(x((i - 1) * N_ind + 1:i * N_ind, :), IE, MI, D);
    end
    
    %% Cultural factors
    task_mi = calculateSimilarityFactor(sp_2D, data_2D, N_sp);

    %% Subgroup evolution
    for t = 1:GX % Generations
        disp(['Current iteration:', num2str(t)]);
        
        %% Parameter settings
        W = 0.9 - 0.5 * t / GX; % Adaptive inertia weight
        
        for i = 1:N_sp % Subgroup iteration
            IE = params.IE{i};
            MI = params.MI{i};

            x_sub = x((i - 1) * N_ind + 1:i * N_ind, :); % Subgroup position
            v_sub = v((i - 1) * N_ind + 1:i * N_ind, :); % Subgroup velocity
            
            %% Task selection
            r_rmp = rand;
            if r_rmp <= rmp
                task_ts = findTopTasks(i, task_mi);
            end
            
            for j = 1:N_ind % Individuals in the subgroup iteration
                if r_rmp <= rmp
                    %% Task-specific migration
                    gbest_ts = mean(gbest(task_ts, :));
                    v_sub(j, :) = W * v_sub(j, :) + C * rand * (pbest(i, :) - x_sub(j, :)) + C * rand * (gbest(i, :) - x_sub(j, :)) + C * rand * (gbest_ts - x_sub(j, :));
                else
                    %% Standard PSO
                    v_sub(j, :) = W * v_sub(j, :) + C * rand * (pbest(i, :) - x_sub(j, :)) + C * rand * (gbest(i, :) - x_sub(j, :));
                end
                
                % Velocity maintenance
                for k = 1:N_bands
                    if v_sub(j, k) > vmax
                        v_sub(j, k) = vmax;
                    elseif  v_sub(j, k) < vmin
                        v_sub(j, k) = vmin;
                    end
                end
                
                %% Update position
                x_sub(j, :) = x_sub(j, :) + v_sub(j, :);
                
                %% Velocity and position constraints
                for k = 1:N_bands
                    if x_sub(j, k) > 1
                        if rand < 0.5
                            x_sub(j, k) = 1;
                            v_sub(j, k) = -v_sub(j, k);
                        else
                            x_sub(j, k) = rand;  % Random initialization
                            v_sub(j, k) = rand * 0.5;
                        end
                    end
                    
                    if x_sub(j, k) <= 0
                        if rand < 0.5
                            x_sub(j, k) = 0;
                            v_sub(j, k) = -v_sub(j, k);
                        else
                            x_sub(j, k) = rand;  % Random initialization
                            v_sub(j, k) = rand * 0.5;
                        end
                    end
                end
                
                % Dominance relationship
                domiRel = compareDominanceRelationship(pbest((i - 1) * N_ind + j, :), x_sub(j, :), IE, MI, D);
                
                if domiRel == -1 % New solution dominates pbest
                    pbest((i - 1) * N_ind + j, :) = x_sub(j, :);
                elseif rand * 2 < 1 % New solution and pbest are non-dominating to each other
                    pbest((i - 1) * N_ind + j, :) = x_sub(j, :);
                end
                
                x((i - 1) * N_ind + 1:i * N_ind, :) = x_sub;
                v((i - 1) * N_ind + 1:i * N_ind, :) = v_sub;
                
                %% Update gbest
                [best, fv_best] = getGlobalBestParticle(x_sub, IE, MI, D);
                fbest = 1 / (1.0 + exp(-1.0 * (1 - fv_best(1)))) * 1 / (1.0 + exp(-1.0 * fv_best(2)));
                fgbest = 1 / (1.0 + exp(-1.0 * (1 - fv_gbest(i, 1)))) * 1 / (1.0 + exp(-1.0 * fv_gbest(i, 2)));
                
                if fbest < fgbest
                    gbest(i, :) = best;
                    fv_gbest(i, :) = fv_best;
                end
            end
        end
    end
end
