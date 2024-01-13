% Clearing environment variables
clear;
close all;
clc;
warning off;

% Parameters for data
data_type = 'IP';       % Type of data to be processed
num_classes = 16;        % Number of classes in the data
params.N_m = 2;         % Number of objective functions
params.N_sp = 32;       % Number of subtasks
params.N_ind = 5;       % Number of individuals in a subtask
params.GX = 100;        % Number of generations
params.D = 30;          % The number of selected bands
params.rmp = 0.5;       % Migration probability
params.C = 1.49445;     % Learning factor
% Load data
[data, label, img_PCA] = loadData(data_type);
[data_2D, params.sp_2D, task_sm] = constructTask(data, img_PCA, params);
[params.IE, params.MI] = calculateFitness(data_2D, params.sp_2D, params.N_sp);

% Run SS_EMT
[data_2D, sp_2D, gbest, N_sp] = SS_EMT(data, img_PCA, params);
