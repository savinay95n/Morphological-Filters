%%%%%%%%%%%%% meanandstd.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:
%       To get the mean and stanadard deviation of the largest disk
%
% Input Variables:
%       im       MxN input 2D gray-scale image to be filtered
%
% Returned Results:
%       mu      mean of the large disk
%       std     standard deviation of large disk
%
% Processing Flow:
%       1. Find region of larger disk by trail and error.
%       2. Fidn mean and std of that region.
%
% The following functions are called:  
%       mean2:     mean of the region
%       std2:    standard deviation of region
%
% Author:      Savinay Nagendra, Prapti Panigrahi, Sweekar Sudhakara and 
%              Nagarjuna Pampana
% Date:        3/24/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mu,std]= mean_std(im)

% obtained from traial and error
disk=im(60:170,62:132);
mu=mean2(disk);
std=std2(disk);

return