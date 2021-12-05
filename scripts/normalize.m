function[normalized] = normalize(f)
    divisor = sqrt(sum(f.^2));
    normalized = f ./ divisor;
end

