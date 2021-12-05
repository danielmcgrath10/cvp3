function [disparity] = getDisparity(im1, im2, fundMatrix)
    x_len = size(im1, 1);
    y_len = size(im2, 2);
    
    
    for i = 1:x_len
        for j = 1:y_len
            xl = [i j 1];
            xr_e = xl * fundMatrix;
            % Making quick assumption that line is horizontal since that is
            % true for both examples. Will try to expand to apply to sloped
            % lines if time allows
            row = xr_e(3);
            points = [1:x_len; ones(1,x_len) * row];
            
            ncc_max = ncc_correspondences(im1, im2, xl, points, 2, 1);

%             if xr_e(1) < x_len && xr_e(2) < y_len
%                 correspondences(end + 1) = xr_e;
%             end
        end
    end
    
    disparity = ncc_max;
    
    
    