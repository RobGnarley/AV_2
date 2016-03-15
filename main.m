% Load data (into pcl_cell)
load('av_pcl.mat')
% get target point cloud and sphere centres 
[target_pxls, sphere_params_all] = get_objects(pcl_cell);

% Chossing #10 as base image, most info

BASE = 10;

for i = 1:16
    
    if i ~= BASE
        
        transformed_pxls = transform(target_pxls{i},target_pxls{BASE},...
            sphere_params_all{i},sphere_params_all{BASE});

