global model planelist planenorm facelines

X = cell(16);

for i = 1:16
   
    R = pcl_cell{i};
    
    [NumRows,NumCols,W] = size(R);
    R = reshape(R, [NumRows*NumCols,W]);
    
    figure
    % hold on
    % plot3(R(:,4),R(:,5),R(:,6),'k.')

    [NPts,W] = size(R);
    patchid = zeros(NPts,1);
    planelist = zeros(20,4);

    % find surface patches
    % here just get 5 first planes - a more intelligent process should be
    % used in practice. Here we hope the 4 largest will be included in the
    % 5 by virtue of their size
    remaining = R;
    for j = 1 : 1   

        % select a random small surface patch
        [oldlist,plane] = bg_select_patch(remaining);

        % grow patch
        stillgrowing = 1;
        while stillgrowing
            % find neighbouring points that lie in plane
            stillgrowing = 0;
            [newlist,remaining] = bg_getallpoints(plane,oldlist,remaining,NPts);
            [NewL,W] = size(newlist);
            [OldL,W] = size(oldlist);
            if j == 1
            plot3(newlist(:,4),newlist(:,5),newlist(:,6),'r.')
            save1=newlist;
            end
            pause(1)
    
            if NewL > OldL + 50
                % refit plane
                [newplane,fit] = bg_fitplane(newlist);
                [newplane',fit,NewL]
                planelist(j,:) = newplane';
                if fit > 0.04*NewL       % bad fit - stop growing
                    break
                end
                stillgrowing = 1;
                oldlist = newlist;
                plane = newplane;
            end
        end

        waiting=1
        pause(1)

        ['**************** Segmentation Completed']

    end
    %plot3(remaining(:,1),remaining(:,2),remaining(:,3),'y.')
    planelist(1:5,:)


    modelfile
%planelist = [
%   0.0018   -0.0086    1.0000  179.2485
%   -0.0755    0.7003    0.7099  281.2463
%   -0.6378   -0.5599    0.5290  203.6537
%    0.7693   -0.4002    0.4979 -274.8765
%];


    pairs = zeros(100,2);
    success = itree(3,0,3,pairs,0,4);
    if success
        ['model recognised in this image']
    
    end
    if ~success
      ['no models recognised in this image']
    end
    
    X{i} = remaining;
                                                                        
   
end
    
