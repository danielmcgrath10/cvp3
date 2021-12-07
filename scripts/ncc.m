function [ncc_max] = ncc(image1, image2, point, search_space, ncc_mesh, ncc_thresh)
ncc = zeros(1, length(search_space));
for j = 1:length(search_space)
    corr = search_space(:, j);
    xl1 = round(point(2) - ncc_mesh);
    xh1 = round(point(2) + ncc_mesh);
    yl1 = round(point(1) - ncc_mesh);
    yh1 = round(point(1) + ncc_mesh);

    xl2 = round(corr(2) - ncc_mesh);
    xh2 = round(corr(2) + ncc_mesh);
    yl2 = round(corr(1) - ncc_mesh);
    yh2 = round(corr(1) + ncc_mesh);

    % exclude corners along the border of the mesh
    if (xl1 > 1 && xh1 < size(image1, 1) &&...
        yl1 > 1 && yh1 < size(image1, 2) &&...
        xl2 > 1 && xh2 < size(image2, 1) &&...
        yl2 > 1 && yh2 < size(image2, 2))
        mesh1 = image1(xl1:xh1, yl1:yh1);
        mesh2 = image2(xl2:xh2, yl2:yh2);
        nccval = max(max(normxcorr2(mesh1,mesh2)));
        if(nccval > ncc_thresh)
            ncc(j) = nccval;
        end
    end
end

ncc_max = max(ncc);
end

