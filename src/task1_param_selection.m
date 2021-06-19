clc();
clf();
clear;
close all;
disp("TASK 1 parameter selection");

right_image = double(imread('images/tsukuba_right.png')) ;
left_image = double(imread('images/tsukuba_left.png'));

for d = 15:5:15   
    
    for w = 3:3:12
        i=1;
        figure()           
        for s = 3:2:15
            [ cost_volume_left, cost_volume_right] = cost_volume( left_image, right_image, d, w, s );
            [min_l, ind_l] = min(cost_volume_left,[] ,3,'omitnan');

            subplot(4,2,i)   
            imagesc(ind_l);
            title(sprintf("Max d:%d, Window: %d, smoothing: %d",d, w, s))
            colormap('gray');
            colorbar;
            i = i+1;
        end
    end
    
end







