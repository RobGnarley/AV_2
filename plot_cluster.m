for i = 1:16

figure(i)
    
plot3(Y{i}(idxs{i} == 1,4),Y{i}(idxs{i} == 1,5),Y{i}(idxs{i} == 1,6),'r.')
hold on
plot3(Y{i}(idxs{i} == 2,4),Y{i}(idxs{i} == 2,5),Y{i}(idxs{i} == 2,6),'g.')
plot3(Y{i}(idxs{i} == 3,4),Y{i}(idxs{i} == 3,5),Y{i}(idxs{i} == 3,6),'b.')
plot3(Y{i}(idxs{i} == 4,4),Y{i}(idxs{i} == 4,5),Y{i}(idxs{i} == 4,6),'m.')
plot3(Y{i}(idxs{i} == 5,4),Y{i}(idxs{i} == 5,5),Y{i}(idxs{i} == 5,6),'c.')
plot3(Y{i}(idxs{i} == 6,4),Y{i}(idxs{i} == 6,5),Y{i}(idxs{i} == 6,6),'y.')

end