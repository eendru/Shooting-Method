function [ filename ] = wrfilepvmtrx( data, pv, dimension )
%WRFILEPVMTRX Summary of this function goes here
%   Write to file pv*matrix

    filename = 'basicmatrixfile.m';
    fid = fopen(filename, 'w');
    fprintf(fid, '  function [ result ] = basicmatrixfile(dimension) \n\r');
    fprintf(fid, '  result = zeros(dimension);\n\r');

    for i = 1 : 1 : dimension 
        for j = 1 : 1 : dimension
            fprintf(fid,  sprintf('result(%d, %d) = %f; \n' , i, j, data{i, j}));
        end
    end
  
    fprintf(fid, 'end \n\r');
    fclose(fid);  
    

    
    filename = 'pvfile.m';
    fid = fopen(filename, 'w');
    fprintf(fid, '  function [ result ] = pvfile(v, w0) \n\r');
    %fprintf(fid, '  result = zeros(dimension);\n\r');

    fprintf(fid,  sprintf('result = %s; \n' ,pv));
            
  
    fprintf(fid, 'end \n\r');
    fclose(fid);  
    



end

