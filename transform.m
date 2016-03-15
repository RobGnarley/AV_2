function [ transformed_pxls, sphere_1, sphere_2, sphere_3 ] = transform( target_pxls, target_spheres, base_spheres )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Get target vectors
target_v1 = target_spheres{1} - target_spheres{2};
target_v2 = target_spheres{2} - target_spheres{3};
target_v3 = target_spheres{3} - target_spheres{1};

target_v1 = target_v1 / norm(target_v1);
target_v2 = target_v2 / norm(target_v2);
target_v3 = target_v3 / norm(target_v3);

T = [target_v1', target_v2', target_v3'];

% Get base vectors
base_v1 = base_spheres{1} - base_spheres{2};
base_v2 = base_spheres{2} - base_spheres{3};
base_v3 = base_spheres{3} - base_spheres{1};

base_v1 = base_v1 / norm(base_v1);
base_v2 = base_v2 / norm(base_v2);
base_v3 = base_v3 / norm(base_v3);

B = [base_v1', base_v2', base_v3'];

% Estimate Rotation
[U,~,V] = svd(T*B');
R = V*U';
dV = det(V);

if dV < 0
    neg = [1, 1, -1;1, 1, -1;1, 1, -1];
    V = V .* neg;
    R = V*U';
end

% Estimate Translation
dist_1 = base_spheres{1}' - R * target_spheres{1}';
dist_2 = base_spheres{2}' - R * target_spheres{2}';
dist_3 = base_spheres{3}' - R * target_spheres{3}';

t = mean([dist_1,dist_2,dist_3],2);

sphere_1 = R * target_spheres{1}' + t;
sphere_2 = R * target_spheres{2}' + t;
sphere_3 = R * target_spheres{3}' + t;

[N,D] = size(target_pxls);
transformed_pxls = zeros(N,D);
for i = 1:N
    
    rgb = target_pxls(i,1:3);
    xyz = target_pxls(i,4:6);
    
    Rxyz_t = (R * xyz') + t;
    
    transformed_pxls(i,1:3) = rgb;
    transformed_pxls(i,4:6) = Rxyz_t';

end


