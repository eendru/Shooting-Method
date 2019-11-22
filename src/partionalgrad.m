  function [ pG ] = partionalgrad(v, w, dimension, k) 
  pG = zeros( dimension , 1);
pG(1) = 1.000000*(((0) + (2.000000) * (v(1))) + (1.000000) * (v(2))) + 2.000000*(1.000000*(v(1)) - (1.000000)*(1)); 
pG(2) = 1.000000*(((0) + (2.000000) * (v(1))) + (-1.000000) * (v(2))) + 2.000000*(1.000000*(v(2)) - (1.000000)*(0)); 
end 
