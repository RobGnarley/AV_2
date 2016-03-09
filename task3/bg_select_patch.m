% find a candidate planar patch
function [fitlist,plane] = bg_select_patch(points)
  
  [L,~] = size(points);
  tmpnew = zeros(L,6);
  tmprest = zeros(L,6);

  % pick a random point until a successful plane is found
  success = 0;
  while ~success
    idx = 30000; %floor(L*rand)
    pnt = points(idx,4:6);
        if sum(pnt) == 0
            continue
        end
    % find points in the neighborhood of the given point
    DISTTOL = .005;

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
      [plane,resid] = bg_fitplane(tmpnew(1:fitcount,:))
      if resid < 0.1
        fitlist = tmpnew(1:fitcount,:);
        return
      end
    end
  end  
