clc();
clf();
clear;
close all;
disp("TASK 4- test set");


set_paths = ["images/2001_dataset/barn1/" "images/2001_dataset/barn2/"...
            "images/2001_dataset/bull/" "images/2001_dataset/sawtooth/"...
            "images/2001_dataset/venus/"];

[x, set_path_size] = size(set_paths);
scores=zeros(1, set_path_size);

for i=1:set_path_size
    scores(i)= score_set(set_paths(i),20,1);    
end

function error_score = score_set(path,max_disp,disp_out)
    
    left_image = imread(strcat(path, "im2.ppm")) ;
    right_image= imread(strcat(path , "im6.ppm")) ;
    
    % groundtruth is scaled by factor 8!!! reverse to compare with  our
    % results
    left_disp = double(imread(strcat(path, "disp2.pgm"))) / 8 ;
    right_disp= double(imread(strcat(path, "disp6.pgm"))) / 8 ;
    % calculate our solution
    [calc_left, calc_right] = calc_depth_simple(left_image, right_image, max_disp);
    
    % calculate errors
    
    error_left = abs(left_disp - calc_left);
    error_right = abs(right_disp - calc_right);
    
    if disp_out(1)==1
        figure();
        subplot(3,2,1)
        imagesc(left_image);
        title("input left")
        
        
        subplot(3,2,2)
        imagesc(right_image);
        title("input right")
        
        subplot(3,2,3)
        imagesc(calc_left);
        title("calculated left")
        colormap('gray');
        colorbar;
        
        subplot(3,2,4)
        imagesc(calc_right);
        title("calulated right")
        colormap('gray');
        colorbar;
   
        subplot(3,2,5)
        imagesc(left_disp);
        title("groundtruth left")
        colormap('gray');
        colorbar;
        
        subplot(3,2,6)
        imagesc(right_disp);
        title("groundtruth right")
        colormap('gray');
        colorbar;

        figure();
        subplot(1,2,1)
        imagesc(error_left);
        title("errors left")   
        colormap('default')
        colorbar;

        subplot(1,2,2)
        imagesc(error_right);
        title("errors right")            
        colormap('default')
        colorbar;
    end
        
    % error score is average absoluto error over both left&right images
    error_score = mean([sum(abs(error_left),'all'), sum(abs(error_right),'all')],'all');
    fprintf("test image group: %s : abs avg error: %.2f\n\n", path, error_score)

end

