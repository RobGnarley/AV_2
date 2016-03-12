for i = 1:1
    
    figure
    
    I = pcl_cell{i};
    
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    r = R ./ sqrt(R.^2 + G.^2 + B.^2);
    g = G ./ sqrt(R.^2 + G.^2 + B.^2);
    b = B ./ sqrt(R.^2 + G.^2 + B.^2);
    
    norm(:,:,1) = r;
    norm(:,:,2) = g;
    norm(:,:,3) = b;
    
    imshow(norm)
    
end