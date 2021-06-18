function [cleaned_left, cleaned_right] = find_occlusions(depth_left, depth_right, disp_flag )
%POST_PROCESSING 
%   part 1 of our post processing, which is identifiying pixels that fail
%   a left&right consistency check. That's done for both depth maps, set
%   disp_flag to 1 to generate output images

    
    [height,width] = size(depth_left);   
    % generate row and colums subscripts which we will need for generate an
    % index for "dispariated" pixels
    row_subscripts = repmat((1:height)', [1 width]);
    column_subscripts = repmat(1:width, [height 1]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % left depth map    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    % shift column subsribts by disparity
    column_subscripts_l = column_subscripts - depth_left;
    % clamp negative disparities to 1
    column_subscripts_l(column_subscripts_l<1) = 1;
    % build index
    indices = sub2ind([height,width],row_subscripts,column_subscripts_l);
    
    
    cleaned_left = depth_left;
    % calculate depth difference
    diff = abs(depth_left - depth_right(indices));
    % set pixels that failed our consistency check to 
    cleaned_left(diff>=1) = NaN;
    
    if disp_flag == 1
        figure, imagesc(cleaned_left);
        colormap('gray');
        colorbar;
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % same for the right depth map    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    % shift column subsribts by disparity
    column_subscripts_r =  column_subscripts + depth_right;
    % clamp shift of disparities to width at max
    column_subscripts_r(column_subscripts_r > width) = width;
    % build index
    indices = sub2ind([height,width],row_subscripts,column_subscripts_r);

    cleaned_right = depth_right;
    % calculate depth difference
    diff = abs(depth_right - depth_left(indices));
    % set pixels that failed our consistency check to 
    cleaned_right(diff>=1) = NaN;
    
    
    if disp_flag == 1
        figure, imagesc(cleaned_right);
        colormap('gray');
        colorbar;
    end
    
end

