function [ alpha ] = alignalpha( alpha_in, num_iter)
%ALIGNALPHA Summary of this function goes here
%   Detailed explanation goes here
    if (length(alpha_in) == 1)
        alpha = ones(num_iter, 1) * alpha_in;
    elseif (length (alpha_in) < num_iter)
        
        alpha = [alpha_in, ones(1, num_iter-length (alpha_in))*alpha_in(length(alpha_in))];
    elseif (length (alpha_in) == num_iter)
    end
        

end

