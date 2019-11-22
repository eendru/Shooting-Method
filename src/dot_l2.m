function [ result ] = dot_l2(v1, v2, left, right, N)

    result = dot(v1, v2) * ((right-left)/N);

end

