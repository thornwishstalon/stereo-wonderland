function [cost_volume] = cost_volume(right_image,left_image, max_disparity, window_size)
%COST_VOLUME calculate the cost_volume for a given pair of images, 
%   Detailed explanation goes here

[height, width, colors] = size(right_image);

disparities = [ 0:max_disparity ];

cost_volume = zeros( height, width, max_disparity + 1 );

% precalculate neighborhoods for the given window size
c_l_r = colfilt(left_image(:,:,1),[window_size window_size],'sliding',@sum);
c_l_g = colfilt(left_image(:,:,2),[window_size window_size],'sliding',@sum);
c_l_b = colfilt(left_image(:,:,3),[window_size window_size],'sliding',@sum);

c_r_r = colfilt(right_image(:,:,1),[window_size window_size],'sliding',@sum);
c_r_g = colfilt(right_image(:,:,2),[window_size window_size],'sliding',@sum);
c_r_b = colfilt(right_image(:,:,3),[window_size window_size],'sliding',@sum);

base = zeros(height, width);


for d = disparities
    % red
    tmp_r = base;    
    tmp_r(:,1:end-d) = c_r_r(:,1+d:end);
    
    tmp_g = base;
    tmp_g(:,1:end-d) = c_r_g(:,1+d:end);
    
    tmp_b = base;
    tmp_b(:,1:end-d) = c_r_b(:,1+d:end);
    % extend the cost volume array
    
    
    cost_volume(:,:,d+1) = abs((c_l_r + c_l_g + c_l_b) - (tmp_r + tmp_g + tmp_b) );    
    
end
%imshow(mat2gray(cost_volume(:,:,15)))

end
 

