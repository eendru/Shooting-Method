function [ filename ] = wrfiledistmtrx( basicA, disturbedA,  dimension )
%WRFILEDISTMTRX Summary of this function goes here
%   Detailed explanation goes hered

    filename = 'disturbedmatrixfile.m';
    fid = fopen(filename, 'w');
    fprintf(fid, '  function [ result ] = disturbedmatrixfile() \n\r');
    fprintf(fid, '  result = cell(%d, %d);\n\r', dimension, dimension); 
    fprintf(fid, '  k = sym(''%s''); \n\r', sprintf('k'));
    
    for i = 1 : 1 : dimension 
        for j = 1 : 1 : dimension
            if isnumeric(disturbedA{i, j})
                fprintf(fid,  sprintf('result{%d, %d} = (%d) + (%d); \n' , i, j, basicA(i, j), disturbedA{i, j} ));
            else
                fprintf(fid,  sprintf('result{%d, %d} = (%d) + (%s); \n' , i, j,  basicA(i, j), char(disturbedA{i, j})));
            end
        end
    end
    
    
    fprintf(fid, 'end \n\r');
    fclose(fid);  

end

