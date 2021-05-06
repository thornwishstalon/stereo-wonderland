disp("TASK 1");
clear;
close all;

right_image = imread('images/tsukuba_right.png');
left_image = imread('images/tsukuba_left.png');

window_size = 5;
max_disparity = 15;

c = cost_volume( left_image, right_image, max_disparity, window_size);

[min, ind] = min(c,[],3,'omitnan');

imagesc(c(:,:,1))
figure()
imagesc(c(:,:,5))
figure()
imagesc(c(:,:,10))

figure()
imagesc(ind)
