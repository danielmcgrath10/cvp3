function [rgb_images, gray_images] = import_images(x, y, start, stop)
%IMPORT_IMAGES Summary of this function goes here
%   Detailed explanation goes here


    directory = uigetdir(pwd, 'Select a Folder');
    filePattern = fullfile(directory, '*.jpg');
    imageFiles = dir(filePattern);
    numImages = length(imageFiles);
%     rgb_images = zeros(x, y, 3, numImages);
%     gray_images = zeros(x, y, numImages);
    
    if start == 0
       start = 1; 
    end
    if stop == 0
       stop = numImages; 
    end
    
    for i = start:stop
        file = imageFiles(i);
        rgb_images(:,:,:,i) = imread(strcat(file.folder,'/',file.name));
        gray_images(:,:,i) = rgb2gray(rgb_images(:,:,:,i));
    end
end

