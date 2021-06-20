clc();
clf();
clear;
close all;
disp("TASK 2 parameter selection");

right_image = double(imread('images/tsukuba_right.png')) ;
left_image = double(imread('images/tsukuba_left.png'));



%for c_window = 3:2:7
for c_window = 3:2:5
    %for smooth=0.25:0.25:1
    % lets fix smoothness on .5
    for smooth=0.5:0.5
        i=1;
        figure() 
        for guided_size = 21:3:36       

            [ cost_volume_left, cost_volume_right] = guided_cost_volume( left_image, right_image, 15 , c_window, guided_size, smooth);
            [min_l, ind_l] = min(cost_volume_left,[] ,3);

            subplot(3,2,i)   
            imagesc(ind_l);
            title(sprintf("Max d:%d, cost-Window: %d, smoothing: %0.2f, guided-Window: %d ",15, c_window, smooth ,guided_size))
            colormap('gray');
            colorbar;
            i = i+1;   
        end
    end
end







