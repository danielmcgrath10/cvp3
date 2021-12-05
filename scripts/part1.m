close all;
clearvars;

[rgb_images, images] = import_images(340, 512, 0, 0);

% MinQuality establishes thresholding of [ratio] multiplied by the maximum
% corner quality value (relative thresholding at [ratio] * 100 %)
harris_ratio = 0.1;
corners_1 = detectHarrisFeatures(images(:,:,1), 'MinQuality', harris_ratio);
corners_2 = detectHarrisFeatures(images(:,:,2), 'MinQuality', harris_ratio);
ncc_thresh = 0.8;
ncc_mesh = 3;

nonmax_distance = 3.0;
corners_1_nonmax = nonmax_suppression(corners_1, nonmax_distance);
corners_2_nonmax = nonmax_suppression(corners_2, nonmax_distance);

corners1 = round(corners_1_nonmax.Location);
corners2 = round(corners_2_nonmax.Location);

figure;
colormap gray;
imshow(rgb_images(:,:,:,2)); hold on;
plot(corners_2_nonmax);
hold off;

[im1corners, im2corners] = ncc_correspondences(images(:,:,1), images(:,:,2), corners1, corners2, ncc_mesh, ncc_thresh);

figure;
ax = axes;
showMatchedFeatures(rgb_images(:,:,:,1),rgb_images(:,:,:,2),im1corners,im2corners,'montage','Parent',ax);

correspondences = [im1corners(:,2), im1corners(:,1), im2corners(:,2), im2corners(:,1)];

ransac_iterations = 1000;
ransac_distance = 5.0;

[ransac_H, ransac_inliers] = my_ransac(correspondences, ransac_iterations, ransac_distance);

disp(max(ransac_inliers));

im2 = double(images(:,:,2));
[xi, yi] = meshgrid(1:512, 1:340);
h = inv(ransac_H);
xx = (h(1,1)*xi+h(1,2)*yi+h(1,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));
yy = (h(2,1)*xi+h(2,2)*yi+h(2,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));
foo = uint8(interp2(im2,xx,yy));
figure(1); imshow(foo)


h = inv(ransac_H);
im1 = images(:,:,1);
im = double(images(:,:,2));
[xi,yi] = meshgrid(1:size(im, 2), 1:size(im, 1));
xx = (h(1,1) * xi + h(1,2) * yi + h(1,3))./(h(3,1) * xi + h(3,2) * yi + h(3,3));
yy = (h(2,1) * xi + h(2,2) * yi + h(2,3))./(h(3,1) * xi + h(3,2) * yi + h(3,3));
foo = uint8(interp2(im, xx, yy));
figure;
% montage({im1, foo});
imshow(foo);


 


