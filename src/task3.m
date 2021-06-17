clc();
clf();
clear;
close all;
disp("TASK 3- Postprocessing");

right_image = imread('images/tsukuba_right.png') ;
left_image = imread('images/tsukuba_left.png');

window_size =5 ;
max_disparity = 15;

[ cost_volume_left, cost_volume_right] = guided_cost_volume( left_image, right_image, max_disparity, window_size, 32, 0.5); % [5 5] is default
[min_l, ind_l] = min(cost_volume_left,[] ,3,'omitnan');
[min_r, ind_r] = min(cost_volume_right,[] ,3,'omitnan');


figure, imagesc(ind_l);
colormap('gray');
colorbar;

figure, imagesc(ind_r);
colormap('gray');
colorbar;

% consistency check
[cleaned_left, cleaned_right]  = post_processing(ind_l, ind_r, 1);

% occlusion filling
% TODO