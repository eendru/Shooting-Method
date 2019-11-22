function [ result ] = multiplycellbyvector( A, b )
%MULTIPLYCELLBYVECTOR Summary of this function goes here
%   Detailed explanation goes here
    dimension = size(b, 1);
    result = cell (dimension, 1);
    
    for i = 1 : 1 : dimension
        tmp = '0';
         for j = 1 : 1 : dimension
             
             if iscell(A)
                if isnumeric(A{i, j})
                    tmp = sprintf('(%s) + (%f) * (%s)', tmp, A{i, j}, char(b(j)));                             %tmp + A{i, j}*b(j)
                else
                   tmp = sprintf('(%s)  + (%s) * (%s)', tmp, char(A{i, j}), char(b(j)));                             %tmp + A{i, j}*b(j)
                end
                
             else
                 if isnumeric(A(i, j))
                    tmp = sprintf('(%s) + (%f) * (%s)', tmp, A(i, j), char(b(j)));                             %tmp + A{i, j}*b(j)
                else
                   tmp = sprintf('(%s)  + (%s) * (%s)', tmp, char(A(i, j)), char(b(j)));                             %tmp + A{i, j}*b(j)
                end

             end
            
        end
        result{i, 1} = tmp;
    end
    

end

