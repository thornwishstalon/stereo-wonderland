function [filled_left, filled_right] = calc_depth_simple(left_image,right_image, max_disparity)
%CALC_DEPTH aggregated function to calc depth maps for task 4
%   Detailed explanation goes here

    
% fixed parameters!!!!
window_size = 3;


% calculate cost volume
[ cost_volume_left, cost_volume_right] = cost_volume( left_image, right_image, max_disparity, window_size, [3 5]); 
[min_l, ind_l] = min(cost_volume_left,[] ,3);
[min_r, ind_r] = min(cost_volume_right,[] ,3);


% consistency check
[cleaned_left, cleaned_right]  = filter_occlusions(ind_l, ind_r, 0);
% fill occlusions
[filled_left, filled_right]  = fill_occlusions(cleaned_left, cleaned_right,  max_disparity, [0 0 ]);
% smoothing with median filter
filled_left = medfilt2(filled_left);
filled_right = medfilt2(filled_right);


end

