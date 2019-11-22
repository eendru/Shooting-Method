function [ result ] = getAv(vk,  Time )
%GETAV Summary of this function goes here
%   Detailed explanation goes here
  left = Time(1);
  right = Time(end);
  step = abs(abs(Time(2)) - abs(Time(1)));
  
  N = round ((right - left)/step + 1);
  
  v = vk;
  
  v = v';
  result = zeros(size(v));
  
  result(1) = v(1);  % trapz in single point always equal zero
  
  for i = 2 : 1 : N
      result(i) = v(i) + trapz(Time(1:i), v(1:i));
  end
  
  result = result';
  

end

