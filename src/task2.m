clc();
clf();
clear;
close all;
disp("TASK 2");

right_image = imread('images/tsukuba_right.png') ;
left_image = imread('images/tsukuba_left.png');

window_size = 3 ;
max_disparity = 15;
filter_neighborhood = 33; 
filter_smoothing = 0.5;

[ cost_volume_left, cost_volume_right] = guided_cost_volume( left_image, right_image, max_disparity, window_size, filter_neighborhood, filter_smoothing); % [5 5] is default
[min_l, ind_l] = min(cost_volume_left,[] ,3);
[min_r, ind_r] = min(cost_volume_right,[] ,3);

figure()
imagesc(ind_l);
colormap('gray');
colorbar;


figure()
imagesc(ind_r)
colormap('gray');
colorbar;