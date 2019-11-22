function [ result ] = by2vectors( A, B, operation, alpha1, alpha2)

    dimension = size(A, 1);
    result = cell(size(A));
    if (strcmp(operation, 'minus'))
        for i = 1 : 1 : dimension
            if isnumeric(A(i)) && isnumeric(B(i))
                 result{i, 1} = sprintf('%f * (%f) - (%f) * (%f)', alpha1, (A(i)), alpha2, B(i));
            elseif isnumeric(A(i)) && (~isnumeric(B(i)))
                result{i, 1} = sprintf('%f * (%d) - (%f)*(%s)', alpha1, (A(i)), alpha2, char(B(i)));
            elseif (~isnumeric(A(i))) && isnumeric(B(i))
                result{i, 1} = sprintf('%f*(%s) - (%f)*(%d)', alpha1, char(A(i)), alpha2, B(i));
            else
                result{i, 1} = sprintf('%f*(%s) - (%f)*(%s)', alpha1, char(A(i)), alpha2, char(B(i)));
            end
        end
    elseif (strcmp(operation,'plus'))
        
         for i = 1 : 1 : dimension
            if isnumeric(A(i)) && isnumeric(B(i))
                 result{i, 1} = sprintf('%f * (%d) + %f * (%d)', alpha1, (A(i)), alpha2, (B(i)));
            elseif isnumeric(A(i)) && (~isnumeric(B(i)))
                result{i, 1} = sprintf('%f * (%d) + (%f)*(%s)', alpha1, (A(i)), alpha2, char(B(i)));
            elseif (~isnumeric(A(i))) && isnumeric(B(i))
                result{i, 1} = sprintf('%f*(%s) + (%f) * (%d)', alpha1, char(A(i)), alpha2, (B(i)));
            else
                result{i, 1} = sprintf('%f*(%s) + %f*(%s)', alpha1, char(A(i)), alpha2, char(B(i)));
            end
        end
        
    end
    

end

