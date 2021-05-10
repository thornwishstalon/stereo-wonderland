function [ cost_volume_left, cost_volume_right] = cost_volume2(left_image, right_image, max_disparity, window_size)
%COST_VOLUME FASTER calculate the cost_volume for a given pair of images, 
%   Detailed explanation goes here

    [height, width, c] = size(right_image);
    disparities =  0:max_disparity ;

    % init cost volumes
    cost_volume_right = NaN( height, width, max_disparity + 1 );
    cost_volume_left = NaN( height, width, max_disparity + 1 );    
    
    imshow(right_image(:,:,1))
    % calculate sums for windows per channel and per image:
    tmp_r_r = colfilt(right_image(:,:,1), [window_size window_size],'sliding', @sum );
    tmp_l_r = colfilt(left_image(:,:,1), [window_size window_size],'sliding', @sum );
    
    tmp_r_g = colfilt(right_image(:,:,2), [window_size window_size],'sliding', @sum );
    tmp_l_g = colfilt(left_image(:,:,2), [window_size window_size],'sliding', @sum );
    
    tmp_r_b = colfilt(right_image(:,:,3), [window_size window_size],'sliding', @sum );
    tmp_l_b = colfilt(left_image(:,:,3), [window_size window_size],'sliding', @sum );
    
    for d = disparities
        %debug: abs error in red channel at disparity d
        %figure()
        %img = abs(tmp_l_g - shift_right(tmp_r_g, d));
                
        %img = abs(tmp_l_r - shift_right(tmp_l_r, d) );
        %subplot(1,3,1)
        %imagesc(tmp_l_g)
        %subplot(1,3,2)
        %imagesc(tmp_r_g)
        %subplot(1,3,3)
        %imagesc(abs(tmp_l_r - shift_right(tmp_r_r, d)) +  ... 
        %    abs(tmp_l_g - shift_right(tmp_r_g, d)) +  ... 
        %    abs(tmp_l_b - shift_right(tmp_r_b, d)) )
                
        %imshow(gradient(abs(tmp_l_r - shift_right(tmp_r_g, d))))
        
        %left_volume
        cost_volume_left(:,:,d+1) =  ...
            abs(tmp_l_r - shift_right(tmp_r_r, d) ) +  ... 
            abs(tmp_l_g - shift_right(tmp_r_g, d) ) +  ... 
            abs(tmp_l_b - shift_right(tmp_r_b, d) );                
        
        %right_volume
        cost_volume_right(:,:,d+1) = ...
            abs(tmp_r_r - shift_left(tmp_l_r, d) ) +  ...
            abs(tmp_r_g - shift_left(tmp_l_g, d) ) +  ...
            abs(tmp_r_b - shift_left(tmp_l_b, d) );   
        
    end            

end 

function A = shift_left(B, step)
    A = imtranslate(B, [-step 0]);
end

function A = shift_right(B, step)
    A = imtranslate(B, [step 0]);
end