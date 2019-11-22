  function [ pG ] = partionalgradcustom(v, w, dimension, eps) 
  %% Ф(v, w) = eps*exp(-||w||^2)
  % 
  % $$ F(v, w) = \epsilon * e^{-||w||^2} $$
  % 
  pG = -2 * w * eps * exp(-norm(w)^2);
end 

