%%%% OPENCV IMPLEMENTATION %%%%
clearvars;
close all;

[rgb_images, images] = import_images(340, 512, 0, 0);

harris_ratio = 0.01;

rgb_image_1 = rgb_images(:,:,1);
rgb_image_2 = rgb_images(:,:,2);

image_1 = images(:,:,1);
image_2 = images(:,:,2);

corners_1 = detectHarrisFeatures(image_1, 'MinQuality', harris_ratio);
corners_2 = detectHarrisFeatures(image_2, 'MinQuality', harris_ratio);

[f1, vpts1] = extractFeatures(image_1, corners_1);
[f2, vpts2] = extractFeatures(image_2, corners_2);

indexPairs = matchFeatures(f1, f2);
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));

figure; ax=axes;
showMatchedFeatures(image_1, image_2, matchedPoints1, matchedPoints2, 'montage', 'Parent', ax);

im1corners = round(matchedPoints1.Location);
im2corners = round(matchedPoints2.Location);

correspondences = [im1corners, im2corners];
ransac_iterations = 1000;
ransac_distance = 5.0;

[F,inliersIndex] = estimateFundamentalMatrix(correspondences(:,1:2), correspondences(:,3:4), 'Method', 'RANSAC', 'NumTrials', ransac_iterations, 'DistanceThreshold', 1e-4);

matchedPoints1 = correspondences(:,1:2);
matchedPoints2 = correspondences(:,3:4);

figure; 
showMatchedFeatures(images(:,:,1), images(:,:,2), matchedPoints1(inliersIndex,:), matchedPoints2(inliersIndex,:),'montage','PlotOptions',{'ro','go','y--'});

epilines = epipolarLine(F,matchedPoints2(inliersIndex,:));
borderPoints = lineToBorderPoints(epilines, size(images(:,:,1)));

% [disparityMap] = getDisparity(images(:,:,1), images(:,:,2), F);

% j1 = images(:,:,1);
% j2 = images(:,:,2);
% disparityRange = [0 48];
% disparityMap = disparitySGM(j1,j2,'DisparityRange',disparityRange,'UniquenessThreshold',60);
% figure
% imshow(disparityMap)
% colormap jet
% colorbar;