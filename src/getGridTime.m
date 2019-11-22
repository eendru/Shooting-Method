function [ result ] = getGridTime( left, step, t)
%GETGRIDT Summary of this function goes here
%   Detailed explanation goes here
  result = left + round((t-left)/step) * step;
end

