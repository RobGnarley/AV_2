function [ point_cloud ] = get_pixels2( idxs, I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
[R,C,D] = size(I);
[n,~] = size(idxs);
point_cloud = zeros(R,C,D);
%m = 1;

for i = 1:n
    
    if I(idxs(i,2),idxs(i,1),6) ~= 0
        point_cloud(idxs(i,2),idxs(i,1),:) = I(idxs(i,2),idxs(i,1),:);
        %m = m + 1;
    end

end

%point_cloud_final = point_cloud(1:m-1,:);

