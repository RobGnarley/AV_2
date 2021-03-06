for i = 1:16
    
    figure
    
    I = pcl_cell{i};
    I = I(20:460,20:620,:);
    
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    r = R ./ sqrt(R.^2 + G.^2 + B.^2);
    g = G ./ sqrt(R.^2 + G.^2 + B.^2);
    b = B ./ sqrt(R.^2 + G.^2 + B.^2);
    
    %norm(:,:,1) = r;
    %norm(:,:,2) = g;
    %norm(:,:,3) = b;
    
    %imshow(norm)
    
    R2 = imgaussfilt(R,3);
    bw_r = edge(R2,'canny',0.35);
    G2 = imgaussfilt(G,3);
    bw_g = edge(G2,'canny',0.35);
    B2 = imgaussfilt(B,3);
    bw_b = edge(B2,'canny',0.35);
    
    bw = bw_r | bw_g | bw_b;
    %bw2 = bwmorph(bw,'close');
    se90 = strel('line', 4, 90);
    se0 = strel('line', 4, 0);
    seD = strel('diamond',1);
    bw2 = imdilate(bw, [se90 se0]);
    %bw3 = bwmorph(bw,'dilate',5);
    bw3 = imfill(bw2,'holes');
    bw4 = imclearborder(bw3, 4);
    BW = imerode(bw4,seD);
    imshow(BW)
end