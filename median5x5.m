%%%%%%%%%%%%% median5x5.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Compute a 5X5 median (neighborhood median) filter at each pixel 
%       in an image 
%
% Input Variables:
%       im       MxN input 2D gray-scale image to be filtered
% 
% Other Variables:
%       window_size    size of window in which filtering operation is
%                      performed for every pixel
% Returned Results:
%       median_img       new image containing the filtered results
%
% Processing Flow:
%      1.  Pad the image. For each valid pixel,
%          compute the median of the 5x5 neighborhood about the
%          pixel and assign this value to the median image
%
%  Restrictions/Notes:
%      This function takes an 8-bit image as input.  
%
%  The following functions are called:
%      medfilt2 (MATLAB), padding
%
% Author:      Savinay Nagendra, Prapti Panigrahi, Sweekar Sudhakara and 
%              Nagarjuna Pampana
% Date:        3/24/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [median_img] = median5x5(im)

% create padded image
padded_img = padding(im);

% size of input image
[M,N] = size(padded_img);

% window size
window_size = 5;

median_img = medfilt2(padded_img, [window_size,window_size]);

median_img = uint8(median_img(2:M-3, 2:N-3));

return
