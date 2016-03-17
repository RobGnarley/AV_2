function [ planelist ] = find_planes( point_cloud )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

R = point_cloud;
NORMTOL = 0.9;


figure

hold on

%plot3(R(:,4),R(:,5),R(:,6),'k.')

[NPts,W] = size(R);
patchid = zeros(NPts,1);
planelist = zeros(20,4);

% find surface patches
% here just get 5 first planes - a more intelligent process should be
% used in practice. Here we hope the 4 largest will be included in the
% 5 by virtue of their size
remaining = R;
i = 1;
plane_lists = cell(20);

for i = 1 : 9   

    % select a random small surface patch
    [oldlist,plane] = tar_select_patch(remaining, planelist);

    % grow patch
    stillgrowing = 1;
    while stillgrowing

        % find neighbouring points that lie in plane
        stillgrowing = 0;
        [newlist,remaining] = tar_getallpoints(plane,oldlist,remaining,NPts);
        [NewL,W] = size(newlist);
        [OldL,W] = size(oldlist);
        
%         plane_lists{i} = newlist;
%         
%         colours = {'r.','g.','b.','c.','m.','w.','y.','r*','g*','b*','c*','m*','w*','y*'};
%         
%         figure(1)
%         hold on
%         for k = 1:i
%             st = colours(k);
%             plot3(plane_lists{k}(:,4),plane_lists{k}(:,5),plane_lists{k}(:,6),st);
%         end
%         
%         hold off
    
%         if i == 1
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'r.')
%         save1=newlist;
%     
%         elseif i==2 
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'b.')
%         save2=newlist;
%     
%         elseif i == 3
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'g.')
%         save3=newlist;
%     
%         elseif i == 4
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'c.')
%         save4=newlist;
%     
%         elseif i == 5
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'m.')
%         save5=newlist;
%     
%         elseif i == 6
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'y.')
%         save6=newlist;
%     
%         elseif i == 7
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'w.')
%         save7=newlist;
%     
%         elseif i == 8
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'r*')
%         save8=newlist;
%     
%         else
%         plot3(newlist(:,4),newlist(:,5),newlist(:,6),'g*')
%         save9=newlist;
%         end
%         pause(1)
        
        
    
        if NewL > OldL + 1 %50
            % refit plane
            [newplane,fit] = tar_fitplane(newlist);
            %[newplane',fit,NewL]
            
            planelist(i,:) = newplane';
            
            if fit > 0.04*NewL       % bad fit - stop growing
                break
            end
            
            normal = plane(1:3);
            d = plane(4);
            good = true;
            for j = 1:i
                if planelist(j,1) ~= 0 && (i ~= j)
                    normal_j = planelist(j,1:3);
                    d_j = planelist(j,4);
                    if abs(dot(normal,normal_j)) > NORMTOL && abs(d - d_j) < 0.08                       
                        good = false;
                    end
                end
            end
            
            if ~ good
                [oldlist,plane] = tar_select_patch(remaining, planelist);
                stillgrowing = 1;
                remaining = [remaining;newlist];
                continue
            end
            
            stillgrowing = 1;
            oldlist = newlist;
            plane = newplane;
        else
            if i == 1
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[1 0 0],'Marker','.','LineStyle','none')
                save1=newlist;
    
            elseif i==2 
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[0 1 0],'Marker','.','LineStyle','none')
                save2=newlist;
    
            elseif i == 3
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[0 0 1],'Marker','.','LineStyle','none')
                save3=newlist;
    
            elseif i == 4
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[1 1 0],'Marker','.','LineStyle','none')
                save4=newlist;
    
            elseif i == 5
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[0 1 1],'Marker','.','LineStyle','none')
                save5=newlist;
    
            elseif i == 6
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[1 0 1],'Marker','.','LineStyle','none')
                save6=newlist;
    
            elseif i == 7
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[1 0.5 1],'Marker','.','LineStyle','none')
                save7=newlist;
    
            elseif i == 8
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[0.5 0.5 1],'Marker','.','LineStyle','none')
                save8=newlist;
    
            else
                plot3(newlist(:,4),newlist(:,5),newlist(:,6),'Color',[1 0.5 0.5],'Marker','.','LineStyle','none')
                save9=newlist;
            end
        end
    
    end

waiting=1
pause(1)

['**************** Segmentation Completed']

end
%plot3(remaining(:,1),remaining(:,2),remaining(:,3),'y.')

%planelist(1:5,:)


%modelfile
%planelist = [
%   0.0018   -0.0086    1.0000  179.2485
%   -0.0755    0.7003    0.7099  281.2463
%   -0.6378   -0.5599    0.5290  203.6537
%    0.7693   -0.4002    0.4979 -274.8765
%];                                                          


end

