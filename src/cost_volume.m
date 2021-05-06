function [cost_volume] = cost_volume(left_image, right_image, max_disparity, window_size)
%COST_VOLUME calculate the cost_volume for a given pair of images, 
%   Detailed explanation goes here

[height, width, c] = size(right_image);

disparities =  0:max_disparity ;

cost_volume = NaN( height, width, max_disparity + 1 ) ;

half_window_size = floor(window_size/2);

for d = disparities
    for y =  1:height 
        for x =  1:width 
            if (x-d) > 0 && (y-half_window_size) > 0 && (x-half_window_size) > 0 && (x-half_window_size-d) > 0 && (y+half_window_size) <= height && (x+half_window_size) <= width
                
                cost_volume(y,x,d+1) = calculate_cost(...
                    left_image(y-half_window_size:y+half_window_size,x-half_window_size:x+half_window_size,:),...
                    right_image(y-half_window_size:y+half_window_size,x-half_window_size-d:x+half_window_size-d,:)...
                );                          
            
            end
        end
    end
    
end


end
 

function cost = calculate_cost(left_window, right_window)    
    cost = sum(sum(sum(abs(left_window - right_window))));
end
