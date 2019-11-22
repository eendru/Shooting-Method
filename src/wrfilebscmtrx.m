function [ filename ] = wrfilebscmtrx( A, dimension )
%WRFILEBSCMTRX write to file basic A matrix
	filename = 'basicmatrixfile.m';
    fid = fopen(filename, 'w');
    fprintf(fid, '  function [ result ] = basicmatrixfile(dimension) \n\r');
    fprintf(fid, '  result = zeros(dimension);\n\r');

    for i = 1 : 1 : dimension 
        for j = 1 : 1 : dimension
            fprintf(fid,  sprintf('result(%d, %d) = %f; \n' , i, j, A{i, j}));
        end
    end
  
    fprintf(fid, 'end \n\r');
    fclose(fid);  
    

end

