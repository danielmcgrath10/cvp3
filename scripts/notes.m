% Input: Harris Corner Detection Output (thresholded R values)
% For each pixel (i, j):
% 	1. consider all pixels in immediate surroundings (3x3 mask?)
% 	2. if corner strength is less than one of the surrounding pixels
% 		-> set output at (i, j) to 0