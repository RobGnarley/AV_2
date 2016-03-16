% find a candidate planar patch
function [fitlist,plane] = tar_select_patch(points, planelist)
  
  [L,~] = size(points);
  tmpnew = zeros(L,6);
  tmprest = zeros(L,6);
  [N,D] = size(planelist);
  NORMTOL = 0.7;

  % pick a random point until a successful plane is found
  success = 0;
  while ~success
    idx = floor(L*rand)
    pnt = points(idx,4:6);
        if sum(pnt) == 0
            continue
        end
    % find points in the neighborhood of the given point
    DISTTOL = 0.01;

    fitcount = 0;
    restcount = 0;
    for i = 1 : L
      dist = norm(points(i,4:6) - pnt);
      if dist < DISTTOL
        fitcount = fitcount + 1;
        tmpnew(fitcount,:) = points(i,:);
      else
        restcount = restcount + 1;
        tmprest(restcount,:) = points(i,:);
      end
    end
    oldlist = tmprest(1:restcount,:);

    if fitcount > 10
      % fit a plane
      [plane,resid] = tar_fitplane(tmpnew(1:fitcount,:))
      normal = plane(1:3);
      good = true;
      for j = 1:D
          if planelist(j,1) ~= 0
            normal_j = planelist(j,1:3);
            if abs(dot(normal,normal_j)) > NORMTOL
                good = false;
            end
          end
      end
      if resid < 0.1 && good
        fitlist = tmpnew(1:fitcount,:);
        return
      end
    end
  end  
