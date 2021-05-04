%%%%%%%%%%%%% padding.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Pad an image for a 5x5 sliding window.
%
% Input Variables:
%       im       MxN input 2D gray-scale image to be filtered
%
% Returned Results:
%       padded_img       new image containing the filtered results
%
% Processing Flow:
%       1. Read the input image and get the size.
%       2. Create padded image for a 5x5 window by adding 2 pixel wide
%          padding around the image.
%       
%  Restrictions/Notes:
%      This function takes an 8-bit image as input.  
%
%  The following functions are called:
%      none
%
% Author:      Savinay Nagendra, Prapti Panigrahi, Sweekar Sudhakara and 
%              Nagarjuna Pampana
% Date:        3/24/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function padded_img=padding(im)

% create empty padded image
padded_img=zeros(size(im,1)+2*2,size(im,2)+2*2);

% size of padded image
[m,n]=size(padded_img);

% create padded image
for i=3:m-2
    for j=3:n-2
        padded_img(i,j)=im(i-2,j-2);
    end
end

return