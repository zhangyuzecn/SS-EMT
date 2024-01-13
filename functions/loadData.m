function [data, label, img_PCA] = loadData(data_type)
%LOADDATA Loads data based on the specified data type.
%   [DATA, LABEL, IMG_PCA] = LOADDATA(DATA_TYPE) loads data, labels, and
%   PCA image based on the specified DATA_TYPE.

% Initialize variables
data = [];
label = [];
img_PCA = [];

% Load data based on the specified data type
if strcmp(data_type, 'IP')
    load Indian_pines.mat;
    load Indian_pines_label.mat;
elseif strcmp(data_type, 'PU')
    load PaviaU.mat;
    load PaviaU_label.mat;
elseif strcmp(data_type, 'PC')
    load PaviaC.mat;
    load PaviaC_label.mat;
elseif strcmp(data_type, 'SA')
    load Salinas.mat;
    load Salinas_label.mat;
elseif strcmp(data_type, 'BW')
    load Botswana.mat;
    load Botswana_gt.mat;
    data = Botswana;
    label = Botswana_gt;
elseif strcmp(data_type, 'KSC')
    load KSC.mat;
    load KSC_gt.mat;
    data = KSC;
    label = KSC_gt;
end

% Load PCA image
img_PCA = imread([data_type, '.tif']);

% Reshape label matrix
[M, N] = size(label);
label = reshape(label, M * N, 1);
end
