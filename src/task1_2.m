clc();
clf();
clear;
close all;
disp("TASK 1_2");

right_image = imread('images/tsukuba_right.png');
left_image = imread('images/tsukuba_left.png');

%window size must be odd number! todo add a check in cost_colume()
window_size = 7;
%should be > 0, TOOD add check
max_disparity = 15;

[ cost_volume_left, cost_volume_right] = cost_volume2( left_image, right_image, max_disparity, window_size);


[minc, ind_l] = min(cost_volume_left,[] ,3,'omitnan');
[minc, ind_r] = min(cost_volume_right,[] ,3,'omitnan');

figure();
imagesc(ind_l);

figure()
imagesc(ind_r)