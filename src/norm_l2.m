function [ result] = norm_l2( vk, left, right, N)
%NORM_L2 Summary of this function goes here
%   Detailed explanation goes here
  result = norm(vk)*sqrt((right-left)/N);
end

