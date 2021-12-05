function [final_H, inliers] = my_ransac(correspondences, iterations, max_distance)
%RANSAC Summary of this function goes here
%   Detailed explanation goes here

best_inliers = [];
inliers = zeros(iterations, 1);
H_set = zeros(3, 3, iterations);

for i = 1:iterations
    % Select 4 correspondent corner pairs between images 1 and 2
    samples = randsample(size(correspondences, 1), 4);
    subset = correspondences(samples, :);
    % Compute homography H using algebraic distance on those corner pairs
    H = homography(subset);
    H_set(:,:,i) = H;
    
    current_inliers = subset;
    for j = 1:size(correspondences,1)
        % For each point correspondence detected between images 1 and 2
        c = correspondences(j, :);
        p = [c(1); c(2); 1];
        % Apply H to first image corners and asses "inliers" on second image
        p_prime = H * p;
%         p_prime = sum((H .* p), 2);
        compare = c(3:4)';
        % Determine whether transformed 1 matches 2 (within error)
        if (abs(sum(p_prime(1:2) - compare)) <= max_distance)
           current_inliers(end + 1, :) = c;
        end
    end
    
    inliers(i) = size(current_inliers, 1);
    if (inliers(i) > size(best_inliers, 1))
        best_inliers = current_inliers;
    end
end

final_H = homography(best_inliers);
    % Table the number of inliers for each try
    % If number of inliers > max found so far, keep that set of inliers
% (Kept largest set of inliers)
% Recompute H using algebraic distance with all inliers (of largest set)

end

