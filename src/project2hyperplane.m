function [w] = project2hyperplane( u, c, gamma)
%PROJECTTOHYPERPLANE project u to <c, x> <= gamma

    if (dot(u, c) <= gamma)
        w = u;
    else
        w = u + (gamma - dot(c, u)) * c/(norm(c)^2);
    end
end

