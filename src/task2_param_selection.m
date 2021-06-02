clc();
clf();
clear;
close all;
disp("TASK 2 parameter selection");

right_image = double(imread('images/tsukuba_right.png')) ;
left_image = double(imread('images/tsukuba_left.png'));



for w = 2:5     

    for s = 3:7
        i=1;
        figure() 
        for a = 0.1:0.2:0.9
            [ cost_volume_left, cost_volume_right] = guided_cost_volume( left_image, right_image, 15 , w,[s s], a);
            [min_l, ind_l] = min(cost_volume_left,[] ,3,'omitnan');

            subplot(3,2,i)   
            imagesc(ind_l);
            title(sprintf("Max d:%d, Window: %d, smoothing: %d, n: %d ",15, w, a,s))
            colormap('gray');
            colorbar;
            i = i+1;   
        end
    end
end







