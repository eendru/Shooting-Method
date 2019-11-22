function [ result ] = project2box( Vk, box_alpha, box_beta, tag)
%PROJECTTOBOX Summary of this function goes here
%   Detailed explanation goes here
  


  [~, m] = size(Vk); % 1 x 201
  result = zeros(size(Vk)); 
  
      
      for i = 1 : 1 : m
        if (Vk(:, i) >  box_beta(i))
          result(:, i) =  box_beta(i);
        else
          if (Vk(:, i)  < box_alpha(i))
            result(:, i) = box_alpha(i);
          else
            result(:, i) = Vk(:, i);
          end
        end
      end
      
end

