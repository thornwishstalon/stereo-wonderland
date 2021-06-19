function [ cost_volume_left, cost_volume_right] = guided_cost_volume(left_image, right_image, max_disparity, window_size, neighborhood_size, degree_of_smoothing)
%COST_VOLUME FASTER calculate the cost_volume for a given pair of images, 
%   Detailed explanation goes here

    [height, width, c ] = size(right_image);
    disparities =  0:max_disparity ;

    % init cost volumes
    cost_volume_right = double(ones( height, width, max_disparity + 1 )) * 3/255;
    cost_volume_left = double(ones( height, width, max_disparity + 1 )) * 3/255;
        
    % calculate sums for windows per channel and per image:
    tmp_r_r = colfilt(right_image(:,:,1), [window_size window_size],'sliding', @sum );
    tmp_l_r = colfilt(left_image(:,:,1), [window_size window_size],'sliding', @sum );
    
    tmp_r_g = colfilt(right_image(:,:,2), [window_size window_size],'sliding', @sum );
    tmp_l_g = colfilt(left_image(:,:,2), [window_size window_size],'sliding', @sum );
    
    tmp_r_b = colfilt(right_image(:,:,3), [window_size window_size],'sliding', @sum );
    tmp_l_b = colfilt(left_image(:,:,3), [window_size window_size],'sliding', @sum );
     
        
    for d = disparities
        
        %left_volume
         left =  ...
            abs(tmp_l_r - shift_right(tmp_r_r, d) ) +  ... 
            abs(tmp_l_g - shift_right(tmp_r_g, d) ) +  ... 
            abs(tmp_l_b - shift_right(tmp_r_b, d) );      
        
        %apply smoothing
        cost_volume_left(:,:,d+1) = imguidedfilter(left,left_image,'DegreeOfSmoothing',degree_of_smoothing, 'NeighborhoodSize', neighborhood_size);       
        
        %right_volume
        right = ...
            abs(tmp_r_r - shift_left(tmp_l_r, d) ) +  ...
            abs(tmp_r_g - shift_left(tmp_l_g, d) ) +  ...
            abs(tmp_r_b - shift_left(tmp_l_b, d) );   
        
        %apply guided filter        
        cost_volume_right(:,:,d+1) = imguidedfilter(right,right_image,'DegreeOfSmoothing',degree_of_smoothing, 'NeighborhoodSize', neighborhood_size);        
        
    end  
    
    
end 

function A = shift_left(B, step)
    A = imtranslate(B, [-step 0],'FillValues',NaN);
end

function A = shift_right(B, step)
    A = imtranslate(B, [step 0],'FillValues',NaN);
end