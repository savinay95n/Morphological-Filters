%%%%%%%%%%%%% main.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Iteratively compute filtered image for the given 5 filters and 
%       find their histograms, means and standard deviations.
%
% Input Variables:
%       im       MxN input 2D gray-scale image to be filtered
% 
% Processing Flow:
%       1. Run all the filters on disk.gif
%       2. Save the images at the 1st and the 5th iteration.
%       3. Save the histogram of the final iteration of each filter.
%       4. Calculate mean and standard deviation of the largest disk.
%
%  Restrictions/Notes:
%      This function takes an 8-bit image as input.  
%
%  The following functions are called:
%      1. mean5x5
%      2. median5x5
%      3. alphaTrimmedMean5x5
%      4. sigma5x5
%      5. symmNNMean
%      6. str2func (MATLAB)
%      7. mean_std
%      8. imhist (MATLAB)
%
% Author:      Savinay Nagendra, Prapti Panigrahi, Sweekar Sudhakara and 
%              Nagarjuna Pampana
% Date:        3/24/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read input image
im = uint8(imread('disk.gif'));

% Filter names
filters=["mean5x5" "median5x5" "alphaTrimmedMean5x5" "sigma5x5" "symmNNMean"];

for filt_num = 1 : length(filters)
    
    filter=str2func(filters(filt_num));
    filtered_img =im;
    
    for iter = 1 : 5
        filtered_img = filter(filtered_img);
        if(iter==1|| iter==5)
            [mu,std]=mean_std(filtered_img);
            fprintf('mean of larger disk at iteration %d for %s = %f\n', iter, filters(filt_num), mu);
            fprintf('std of larger disk at iteration %d for %s = %f\n', iter, filters(filt_num), std);
            filename = sprintf('%s_%d.png',filters(filt_num),iter);
            imwrite(filtered_img, filename);
            filename=sprintf('%s_%d_hist.png',filters(filt_num),iter);
            imhist(filtered_img);
            saveas(gcf, filename);
            
        end
    end
end
