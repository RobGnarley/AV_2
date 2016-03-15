function [ point_cloud_final ] = get_pixels( idxs, I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
[n,~] = size(idxs);
point_cloud = zeros(n,6);
m = 1;

for i = 1:n
    
    if I(idxs(i,2),idxs(i,1),6) ~= 0
        point_cloud(m,:) = I(idxs(i,2),idxs(i,1),:);
        m = m + 1;
    end

end

point_cloud_final = point_cloud(1:m-1,:);

