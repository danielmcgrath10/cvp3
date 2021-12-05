function [output] = nonmax_suppression(corners, distance)
%NONMAX_SUPPRESSION Summary of this function goes here
%   Detailed explanation goes here
    output = corners;

    x = 1;
    for i = 1:(output.length - 1)
        for j = (i + 1):output.length
            a = output(i).Location - output(j).Location;
            d = sqrt(sum((a.^2)));
            
            if d <= distance
                x = x + 1;
                if output(i).Metric >= output(j).Metric
                   output(j).Metric = 0; 
                else
                   output(i).Metric = 0;
                end
            end
        end
    end
    output = output.selectStrongest(output.length - x);
end

