function [H] = homography(correspondences)
%HOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here
N = size(correspondences, 1);
% A = zeros(2 * N, 9);
% for i = 1 : N
%     c = correspondences(i, :);
%     x1 = c(1);
%     y1 = c(2);
%     x1p = c(3);
%     y1p = c(4);
%     
%     A((i * 2) - 1, :) = [x1, y1,  1,  0,  0, 0, -(x1*x1p), -(y1*x1p), -(x1p)];
%     A((i * 2), :)     = [ 0,  0,  0, x1, y1, 1, -(x1*y1p), -(y1*y1p), -(y1p)];
% end
% 
% [h, D] = eigs(transpose(A) * A, 1, 'smallestabs');
% if abs(D) > 0.1
%     disp("error!")
% end
% 
%     % reshape
% H = [h(1:3)' ; h(4:6)' ; h(7:9)'];

A = zeros(2 * N, 8);
b = zeros(2 * N, 1);
for i = 1 : N
    c = correspondences(i, :);
    x = c(1);
    y = c(2);
    xp = c(3);
    yp = c(4);
    
    A((i * 2) - 1, :) = [x,   y,  1,  0,  0, 0, -x*xp, -y*xp];
    A((i * 2), :)     = [ 0,  0,  0,  x,  y, 1, -x*yp, -y*yp];
    
    b((i * 2) - 1) = xp;
    b((i * 2))     = yp;
end

h = A \ b;
H = [h(1), h(2), h(3); h(4), h(5), h(6); h(7), h(8), 1];
end

