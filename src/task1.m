disp("hello world");
clear;
close all;

right_image = imread('images/tsukuba_right.png');
left_image = imread('images/tsukuba_left.png');

window_size = 5;
max_disparity = 15;

c = cost_volume(right_image, left_image, max_disparity, window_size);

[min, ind] = min(c,[],3);

imshow(mat2gray(ind))

% TODO select the min costs first!
% imshow(c)