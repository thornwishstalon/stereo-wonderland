clc();
clf();
clear;
close all;
disp("TASK 2 parameter selection");

right_image = double(imread('images/tsukuba_right.png')) ;
left_image = double(imread('images/tsukuba_left.png'));



for w = 4:4:32     
        i=1;
        figure() 
    for s = 3:3:18       
        
        [ cost_volume_left, cost_volume_right] = guided_cost_volume( left_image, right_image, 15 , w, s, 0.5);
        [min_l, ind_l] = min(cost_volume_left,[] ,3,'omitnan');

        subplot(3,2,i)   
        imagesc(ind_l);
        title(sprintf("Max d:%d, Window: %d, smoothing: %0.2f, n: %d ",15, w, 0.5 ,s))
        colormap('gray');
        colorbar;
        i = i+1;   

    end
end







