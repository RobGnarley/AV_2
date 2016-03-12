for i = 1:1
    
    figure
    
    Z = X{i}(X{i}(:,6)~=0,:);
    a = mean(Z(:,1:3),2);
    r = Z(:,1) ./ (a*3);
    g = Z(:,2) ./ (a*3);
    b = Z(:,3) ./ (a*3);
    
    thehist = dohist(a,0);
    thresh = findthresh(thehist,4,0)
    
    thehistr = dohist(r*255,0);
    threshr = findthresh(thehistr,4,0)
    
    thehistg = dohist(g*255,0);
    threshg = findthresh(thehistg,4,0)
    
    thehistb = dohist(b*255,0);
    threshb = findthresh(thehistb,4,0)
    
    a_bin = a > thresh;
    r_bin = r*255 > threshr;
    g_bin = g*255 > threshg;
    b_bin = b*255 > threshb;
    
    Y = Z(a_bin,:);
    
    plot3(Y(:,4),Y(:,5),Y(:,6),'r.')
    
end