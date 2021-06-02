clc();
clf();
clear;
close all;
disp("TASK 1_2");

right_image = single(imread('images/tsukuba_right.png')) / 255;
left_image = single(imread('images/tsukuba_left.png')) / 255;

%window size must be odd number! todo add a check in cost_colume()
window_size = 5;
%should be > 0, TOOD add check
max_disparity = 15;

[ cost_volume_left, cost_volume_right] = cost_volume2( left_image, right_image, max_disparity, window_size);


[minc, ind_l] = min(cost_volume_left,[] ,3,'omitnan');
[minc, ind_r] = min(cost_volume_right,[] ,3,'omitnan');
% average filter
C=fspecial('average',[5,5]);           
%ind_l=imfilter(ind_l,C);
%ind_r=imfilter(ind_r,C);

figure()
imagesc(ind_l);
colormap('gray');
colorbar;


figure()
imagesc(ind_r)
colormap('gray');
colorbar;

