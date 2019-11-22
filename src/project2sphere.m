function [ result ] = project2sphere( Vk, radius, center )
%PROJECTTOSPHERE Project given point Vk to sphere with radius and center

    if (norm(Vk - center, 2) < radius)
        result = Vk;
    else
        result = center + radius * (Vk - center)/norm(Vk - center, 2);
    end
end
   
