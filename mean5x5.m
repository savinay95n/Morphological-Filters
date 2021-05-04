%%%%%%%%%%%%%  Function mean5x5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute a 5X5 mean (neighborhood average) filter at each pixel 
%      in an image 
%
% Input Variables:
%      im       MxN input 2D gray-scale image to be filtered
%      
% Other variables:
%      M, N    rows (M) and columns (N) in f
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      xlo, xhi, ylo, yhi   Limits on what can be processed by filter
%      
% Returned Results:
%     mean_img     new image containing the filtered results
%
% Processing Flow:
%      0.  Pad the image with zeros
%      1.  Set a new image full of ZEROS
%      2.  For each valid pixel,
%             compute the mean of the 5x5 neighborhood about the
%             pixel and assign this value to the mean image
%
%  Restrictions/Notes:
%      This function takes an 8-bit image as input.  
%
%  The following functions are called:
%      padding
%
%  Author:      Savinay Nagendra, Prapti Panigrahi, 
%               Sweekar Sudhakara, Nagarjun Pampana (Taken from Dr. William Higgins)
%  Date:        3/24/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mean_img] = mean5x5(im)

% create padded image
padded_img = padding(im);

% size of input image
[M,N] = size(padded_img);

% Fill the output image with zeroes first
mean_img = zeros(M,N);

% Convert f to a 16-bit number, so we can do  sums > 255 correctly
g = uint16(padded_img);

% Define the coordinate limits for pixels that can be properly
% processed by the 5X5 filter

xlo = 3;   % Can't process first two columns
xhi = M-2; % Can't process last two columns
ylo = 3;   % Can't process first two rows
yhi = N-2; % Can't process last two rows

% Compute the filtered output image

for x = xlo : xhi        % Don't consider boundary pixels that can't
    for y = ylo : yhi    % be processed! 
        for i = -2 : 2
            for j = -2 : 2   
                mean_img(x,y) = g(x-i,y-j) + mean_img(x,y);
            end
        end
        mean_img(x,y) = mean_img(x,y) / 25.;
    end
end

% Convert back to an 8-bit image

mean_img = uint8(mean_img(2:M-3, 2:N-3));

return
