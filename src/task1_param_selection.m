clc();
clf();
clear;
close all;
disp("TASK 1 parameter selection");

right_image = single(imread('images/tsukuba_right.png')) / 255;
left_image = single(imread('images/tsukuba_left.png')) / 255;

%window size must be odd number! todo add a check in cost_colume()
window_size = 5;
%should be > 0, TOOD add check
max_disparity = 15;

for d = 5:5:15   
    
    for w = 3:2:15
        i=1;
        figure()           
        for s = 3:2:15
            [ cost_volume_left, cost_volume_right] = cost_volume( left_image, right_image, d, w, [s s]);
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







