function my_plotpcl(pcls)

figure
hold on

for i = 1:1
    
    kk = pcls{i}(:,:, 6) ~= 0;
    x  = pcls{i}(:,:, 4);
    y  = pcls{i}(:,:, 5);
    z  = pcls{i}(:,:, 6);
    x  = x(kk);
    y  = y(kk);
    z  = z(kk);
    rgbUndistorted = pcls{i}(:,:,1:3)/255;
    [Xim, cm] = rgb2ind(rgbUndistorted, 512);
    Xim = Xim(kk);
    XYZ = [x y z];
    alpha = deg2rad(30);
    R = [1 0 0; 0 cos(alpha) sin(alpha); 0 -sin(alpha) cos(alpha)];
    XYZ = (R*XYZ')';
    fscatter32(XYZ(:,1), XYZ(:,2), XYZ(:,3), Xim, cm)
    zlim([0.2 max(z(:))])
    ylim([0 1])
    xlim([-.5 .5])
    set(gca,'zdir','reverse')
end

  % Show colour image
  %figure(2)
  %image(pcl(:,:,1:3)/255)

  % show depth image
  %figure(3)
  %[H,W]=size(pcl(:,:,1));
  %depth=zeros(H,W);
  %for r = 1 : H
  %for c = 1 : W
  %  depth(r,c) = norm(reshape(pcl(r,c,4:6),1,3));
  %end
  %end
  %M = max(max(depth));
  %m = min(min(depth));
  %depth = (depth - m) / (M-m);
  %imshow(depth.^2)
  
end

