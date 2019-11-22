function [w] = project2hyperplanecont( u, c, gamma, left, right, N)
%PROJECTTOHYPERPLANE project u to <c, x> <= gamma

    if (dot_l2(u, c, left, right, N) <= gamma)
        w = u;
    else
        w = u + (gamma - dot_l2(c, u, left, right, N)) * c/(norm_l2(c, left, right, N)^2);
    end
end

