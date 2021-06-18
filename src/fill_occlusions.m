function [left_filled,right_filled] = fill_occlusions(left_cleaned,right_cleaned,max_disp, disp_flag)
%FILL_OCCLUSIONS Summary of this function goes here
%   foobar  
    
    left_filled = fill_occ(left_cleaned,max_disp,disp_flag);
    right_filled = fill_occ(right_cleaned,max_disp,disp_flag);

end


function filled = fill_occ(cleaned, max_disp ,disp_flag)
%FILL_OCC fill occlusions (marked as NaN) in the depth map.
%   traverses image columns left to right and vice-versa and fills values
%   with the last perceived non NaN value if NaN is ecnountered.
%   returns the minimum of left-to-right and right-to-left candidate.

    [height, width] = size(cleaned);

    % from left to right:
    
    % prefill buffer with max_disp value
    buffer= ones(1,width)*max_disp;
    result_left = cleaned;

    for i = 1:width
        c = cleaned(:,i)    ;    
        c(isnan(c)) = buffer(isnan(c));
        buffer(~isnan(c)) = c(~isnan(c));
        result_left(:,i) = c;
    end

    if disp_flag == 1
        figure, imagesc(result_left);
        colormap('gray');
        colorbar;
    end
    
     % from rigth to left:
    buffer= ones(1,width)*max_disp;
    result_right = cleaned;

    for i = width:-1:1
        c = cleaned(:,i)    ;    
        c(isnan(c)) = buffer(isnan(c));
        buffer(~isnan(c)) = c(~isnan(c));
        result_right(:,i) = c;
    end

    if disp_flag == 1
        figure, imagesc(result_right);
        colormap('gray');
        colorbar;
    end
    
    % take minimum disp values availabile -> prefer background 
    filled = min(result_left, result_right);
    
    if disp_flag == 1
        figure, imagesc(filled);
        colormap('gray');
        colorbar;
    end
       

end