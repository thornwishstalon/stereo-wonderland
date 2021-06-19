clc();
clf();
clear;
close all;
disp("TASK 3- Postprocessing");

right_image = imread('images/tsukuba_right.png') ;
left_image = imread('images/tsukuba_left.png');

window_size = 4;
max_disparity = 15;
% [5 5] is default
filter_neighborhood = 24; %32;
filter_smoothing = 0.5;
disp = 1;
%[ cost_volume_left, cost_volume_right] = cost_volume( left_image, right_image, max_disparity, window_size, [3 5] ); % [5 5] is default

[ cost_volume_left, cost_volume_right] = guided_cost_volume( left_image, right_image, max_disparity, window_size, filter_neighborhood, filter_smoothing); 
[min_l, ind_l] = min(cost_volume_left,[] ,3);
[min_r, ind_r] = min(cost_volume_right,[] ,3);

if disp==1
    figure, imagesc(ind_l);
    title("left depth map")
    colormap('gray');
    colorbar;

    figure, imagesc(ind_r);
    title("right depth map")
    colormap('gray');
    colorbar;
end

% consistency check
[cleaned_left, cleaned_right]  = filter_occlusions(ind_l, ind_r, disp);
% fill occlusions
[filled_left, filled_right]  = fill_occlusions(cleaned_left, cleaned_right,  max_disparity, 0);
% smoothing with median filter
filled_left = medfilt2(filled_left);
filled_right = medfilt2(filled_right);


if disp==1
    figure, imagesc(filled_left);
    title("final left")
    colormap('gray');
    colorbar;

    figure, imagesc(filled_right);
    title("final right")
    colormap('gray');
    colorbar;
end

