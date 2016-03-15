% Load data (into pcl_cell)
load('av_pcl.mat')
% get target point cloud and sphere centres 
[target_pxls, sphere_params_all] = get_objects(pcl_cell);

% Chossing #10 as base image, most info

BASE = 10;

Total_N = 0;
for i = 1:16
    [N,~] = size(target_pxls);
    Total_N = Total_N + N;
end

point_cloud = zeros(Total_N,6);
pointer = 1;

%figure

%hold on

for i = 10:11
    
    if i ~= BASE
        
        [transformed_pxls, s1, s2, s3] = transform(target_pxls{i},...
                                     sphere_params_all{i},sphere_params_all{BASE});
        plot3(s1(1),s1(2),s1(3),'b*')
        plot3(s2(1),s2(2),s2(3),'g*')
        plot3(s3(1),s3(2),s3(3),'m*')
                                 
    else
        transformed_pxls = target_pxls{i};
    end
    
    [N,~] = size(transformed_pxls);
    point_cloud(pointer:pointer+N-1,:) = transformed_pxls;
    
    pointer = pointer + N;

end

plot3(point_cloud(:,4),point_cloud(:,5),point_cloud(:,6),'r.')

