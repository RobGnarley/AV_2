% Load data (into pcl_cell)
load('av_pcl.mat')
% get indexes of target and spheres for all images 
[target_idxs, sphere_idxs] = get_objects(pcl_cell)

for i = 1:3
    [c,r] = sphereFit()