function [ result ] = project2spherecont( Vk, radius, center, left, right, N)
%PROJECTTOSPHERE Project given point Vk to sphere with radius and center

    if (norm_l2(Vk - center, left, right, N) < radius)
        result = Vk;
    else
        result = center + radius * (Vk - center)/norm_l2(Vk - center, left, right, N);
    end
end
   
