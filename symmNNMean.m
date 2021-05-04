%%%%%%%%%%%%% sigma5x5.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Compute a 5X5 symmetric nearest neighbor mean
%       filter at each pixel in an image. 
%
% Input Variables:
%       im       MxN input 2D gray-scale image to be filtered
% 
% Other Variables:
%      M, N    rows (M) and columns (N) in im
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      xlo, xhi, ylo, yhi   Limits on what can be processed by filter
%      nearest_neighbor    array containing symmetrical pairs
%
% Returned Results:
%       snn_mean_img       new image containing the filtered results
%
% Processing Flow:
%       1.  Read the input image, pad it and get the size.
%       2.  Initialize the output image with zeros.
%       3.  Slide over the image using a 5x5 window.
%       4.  For each window, group the symmetrical pairs of pixels together.
%       5.  Subtract the middle element of the window with each value
%           in every pair. 
%       6. Select the pixel from each pair that is closest to the middle
%          pixel value 
%       7. Take the average of all these pixels.
%       8. Take the mean of the averaged value and the original pixel and
%          set this value as the value of filtered image at that pixel.
%
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
function snn_mean_img = symmNNMean(im)

% create padded image
padded_img = padding(im);

% size of input image
[M,N] = size(padded_img);

% Fill the output image with zeroes first
snn_mean_img = zeros(M-4,N-4);

% nearest neighbor array
nearest_neighbor=zeros(12,2);

% Define the coordinate limits for pixels that can be properly
% processed by the 5X5 filter

xlo = 3;   % Can't process first two columns
xhi = M-2; % Can't process last two columns
ylo = 3;   % Can't process first two rows
yhi = N-2; % Can't process last two rows

for x = xlo : xhi        % Don't consider boundary pixels that can't
    for y = ylo : yhi    % be processed! 
        sliding_window = padded_img(x-2:x+2,y-2:y+2);
        index = 1;
        for i = 1 : 3
            for j = 1 : 5 
                if(i==3 && j>2)
                    break;
                else
                    nearest_neighbor(index,1) = sliding_window(i,j);
                    nearest_neighbor(index,2) = sliding_window(5-i+1, 5-j+1);
                    index = index + 1;
                end
            end
        end
        
        nn_diff_arr = nearest_neighbor - padded_img(x,y);
        sum = 0;
        for z = 1:length(nearest_neighbor)
            if abs(nn_diff_arr(z,1)) <= abs(nn_diff_arr(z,2))
                temp = nearest_neighbor(z,1);
            else
                temp = nearest_neighbor(z,2);
            end
            sum = sum + temp;
        end
        
        mean_val = (sum+padded_img(x,y)) / (length(nearest_neighbor) + 1);
        
        snn_mean_img(x,y) = round(mean_val);
        
    end
end
snn_mean_img = uint8(snn_mean_img(2:M-3, 2:N-3));
return