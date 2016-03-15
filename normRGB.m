function [ norm ] = normRGB( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[N,~] = size(I);

R = I(:,1);
G = I(:,2);
B = I(:,3);
    
r = R ./ sqrt(R.^2 + G.^2 + B.^2);
g = G ./ sqrt(R.^2 + G.^2 + B.^2);
b = B ./ sqrt(R.^2 + G.^2 + B.^2);

norm = zeros(N,3);
norm(:,1) = r;
norm(:,2) = g;
norm(:,3) = b;

norm = norm * 255;

end

