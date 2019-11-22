function [ result ] = dotsymvectors( A, B)
%DOTSYMVECTORS Summary of this function goes here
%   Detailed explanation goes here
    
    dimension = size(A, 1);
    
    result = cell(1, 1);
    tmp = '0';
    for i = 1 : 1 : dimension
        tmp =  sprintf('%s + (%s) * (%s)', tmp, char(A(i)), char(B(i)));
    end
    result{1, 1} = tmp; 
 
end

