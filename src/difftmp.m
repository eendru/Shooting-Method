  function [ dv ] = difftmp( t, v )
%DIFFTMP Summary of this function goes here
%   Detailed explanation goes here
  
  dv = zeros(1, 1);
  dw = (-1/((t+1)^2)) * cos(1/(t+1));
  dv(1) = (2 * dw - v(1))*1/3;
end

