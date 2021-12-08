function [disparity_x, disparity_y] = getDisparity(im1, im2, fundMatrix)
    x_len = size(im1, 1);
    y_len = size(im1, 2);
    dx = zeros();
    dy = zeros();
    for i = 2:(x_len-1)
        for j = 2:(y_len-1)
            xl = [i j];
            xr_e = epipolarLine(fundMatrix, xl);
            % Making quick assumption that line is horizontal since that is
            % true for both examples. Will try to expand to apply to sloped
            % lines if time allows
            row = round(xr_e(3));
            if(row > 2 && row < size(im2,1)-1)
                points = im2(row,:);
                ncc_max = ncc(im1, im2, xl, points, 1, 0.1, row);
                dx(i,j) = i - ncc_max;
                dy(i,j) = j - row;
            else
                dx(i,j) = 0;
                dy(i,j) = 0;
            end
        end
    end
    
    disparity_x = dx;
    disparity_y = dy;
    
    