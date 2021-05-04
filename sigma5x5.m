%%%%%%%%%%%%% sigma5x5.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Compute a 5X5 sigma filter at each pixel in an image. 
%
% Input Variables:
%       im       MxN input 2D gray-scale image to be filtered
%       sigma    value of sigma
% 
% Other Variables:
%      M, N    rows (M) and columns (N) in im
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      xlo, xhi, ylo, yhi   Limits on what can be processed by filter
%
% Returned Results:
%       sigma_img       new image containing the filtered results
%
% Processing Flow:
%       1.  Read the input image, pad it and get the size.
%       2.  Initialize the output image with zeros.
%       3.  Slide over the image using a 5x5 window.
%       4.  Subtract each pixel in sliding window with the middle pixel of
%           the window
%       5.  If the difference is less than equal to sigma, add the pixel
%           value to a temporary variable sum.
%       6. Divide this sum by the number of pixels with sigma value 1.
%       6.  If the value is not 0, set this value as pixel value of the
%           filtered img.
%       7.  Else, set the original value as pixel value.
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
function sigma_img = sigma5x5(im, sigma)

if nargin==1
    sigma=20;
end

% create padded image
padded_img = padding(im);

% size of input image
[M,N] = size(padded_img);

% Fill the output image with zeroes first
sigma_img = zeros(M-4,N-4);

% Define the coordinate limits for pixels that can be properly
% processed by the 5X5 filter

xlo = 3;   % Can't process first two columns
xhi = M-2; % Can't process last two columns
ylo = 3;   % Can't process first two rows
yhi = N-2; % Can't process last two rows

for x = xlo : xhi        % Don't consider boundary pixels that can't
    for y = ylo : yhi    % be processed! 
        temp_length = 0;
        sum = 0;
        mid = padded_img(x,y);
        for i = -2 : 2
            for j = -2 : 2 
                if (padded_img(x-i, y-j) - mid) <= 2*sigma
                    sum = sum + padded_img(x-i, y-j);
                    temp_length = temp_length + 1;
                end
            end
        end
        
        % fill the output array
        if (temp_length ~= 0)
            sigma_img(x,y) =round(sum/temp_length);
        else
            sigma_img(x,y) = mid;
        end
    end
end
sigma_img = uint8(sigma_img(2:M-3, 2:N-3));
return



