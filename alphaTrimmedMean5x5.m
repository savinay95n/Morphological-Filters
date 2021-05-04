%%%%%%%%%%%%% alphaTrimmedMean5x5.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Compute a 5X5 alpha trimmed mean (neighborhood alpha trimmed mean) filter at each pixel 
%       in an image 
%
% Input Variables:
%       im       MxN input 2D gray-scale image to be filtered
%       alpha    value of alpha
% 
% Other Variables:
%      M, N    rows (M) and columns (N) in im
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      xlo, xhi, ylo, yhi   Limits on what can be processed by filter
%      window_array    Array of element values in the 5x5 window
% Returned Results:
%       alpha_mean_img       new image containing the filtered results
%
% Processing Flow:
%       1.  Read the input image, pad it and get the size.
%       2.  Initialize the output image with zeros.
%       3.  Slide over the image using a 5x5 window.
%       4.  Store each pixel value from the window in an array. Length of
%           this array will be n = 25.
%       5.  Sort this array.
%       6.  Calculate the sum of the sorted values from
%           [floor(alpha*n)+1 to n-floor(alpha*n)].
%       7.  Divide the sum_val with the the number of elements used to calculate, 
%           i.e., n-2*floor(alpha*n)
%       8.  Set this average value as the pixel value of variable
%           'filtered_img'.%
%       9. Repeat steps 1 to 8 for all pixels.
%  Restrictions/Notes:
%      This function takes an 8-bit image as input.  
%
%  The following functions are called:
%      padding
%
% Author:      Savinay Nagendra, Prapti Panigrahi, Sweekar Sudhakara and 
%              Nagarjuna Pampana
% Date:        3/24/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [alpha_mean_img] = alphaTrimmedMean5x5(im, alpha)

if nargin==1
    alpha=0.25;
end

% create padded image
padded_img = padding(im);

% size of input image
[M,N] = size(padded_img);

% Fill the output image with zeroes first
alpha_mean_img = zeros(M-4,N-4);

% length of array to store values
len_array = 25;

% create an array of size len_array
window_array = zeros(len_array,1);

% Define the coordinate limits for pixels that can be properly
% processed by the 5X5 filter

xlo = 3;   % Can't process first two columns
xhi = M-2; % Can't process last two columns
ylo = 3;   % Can't process first two rows
yhi = N-2; % Can't process last two rows

% Compute the filtered output image

for x = xlo : xhi        % Don't consider boundary pixels that can't
    for y = ylo : yhi    % be processed! 
        index = 0;
        for i = -2 : 2
            for j = -2 : 2 
                index = index + 1;
                window_array(index) = padded_img(x-i,y-j);
            end
        end
        % sort array
        window_array = sort(window_array);
        sum = 0;
        for i = floor(alpha*len_array)+1 : len_array - floor(alpha*len_array)
            sum = sum + window_array(i);
        end
        
        alpha_mean_img(x,y) = sum / (len_array - 2* floor(alpha*len_array));
    end
end

% Convert back to an 8-bit image

alpha_mean_img = uint8(alpha_mean_img(2:M-3, 2:N-3));

return


