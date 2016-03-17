% Load data (into pcl_cell)
load('av_pcl.mat')
% get target point cloud and sphere centres 
[target_pxls, sphere_params_all, target_images] = get_objects(pcl_cell);

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

targets = cell(16);

for i = [1 2 5 6 7 8 9 10 11 12 13]
    
    if i ~= BASE
        
        [transformed_pxls, s1, s2, s3, targets{i}] = transform(target_pxls{i},target_images{i},...
                                     sphere_params_all{i},sphere_params_all{BASE});
        %plot3(s1(1),s1(2),s1(3),'b*')
        %plot3(s2(1),s2(2),s2(3),'g*')
        %plot3(s3(1),s3(2),s3(3),'m*')
                                 
    else
        transformed_pxls = target_pxls{i};
        targets{i} = target_images{i};
    end
    
    [N,~] = size(transformed_pxls);
    point_cloud(pointer:pointer+N-1,:) = transformed_pxls;
    
    pointer = pointer + N;

end

%R = [1 0 0; 0 cos(deg2rad(30)) sin(deg2rad(30));  0 -sin(deg2rad(30)) cos(deg2rad(30))];

%XYZ = point_cloud(:,4:6);
%XYZ = (R * XYZ')';

%R2 = [cos(deg2rad(180)) sin(deg2rad(180)) 0; sin(deg2rad(180)) cos(deg2rad(180)) 0; 0 0 1];

%XYZ = (R2 * XYZ')';

%fscatter32(XYZ(:,1),XYZ(:,2),XYZ(:,3),XYZ(:,3));

%my_plotpcl(targets)

planelist = find_planes( point_cloud );

a = zeros(9,9);
for i = 1:9
    for j = 1:9
        dot_prod = dot(planelist(i,1:3),planelist(j,1:3))
        a(i,j) = acosd(dot_prod)
    end
end

%plot3(point_cloud(:,4),point_cloud(:,5),point_cloud(:,6),'k.')

