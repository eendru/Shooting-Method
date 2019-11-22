function [ result ] = project2boxcont( Vk, box_alpha, box_beta)
%PROJECTTOBOX Summary of this function goes here
%   Detailed explanation goes here
  


  [~, m] = size(Vk); % 1 x 201
  result = zeros(size(Vk)); 
   
  for i = 1 : 1 : m
      if (Vk(i) >  box_beta)
        result(i) =  box_beta;
      else
        if (Vk(i)  < box_alpha)
          result(i) = box_alpha;
        else
          result(i) = Vk(i);
        end
      end
  end
    
    
end

