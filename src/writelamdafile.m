function [ filename ] = writelamdafile(lambda)
%WRFILENUMGRAD return name of file with gradient
%   Detailed explanation goes here
 
    filename = sprintf('lambdafile.m');
    fID = fopen(filename, 'w');
   
    fprintf(fID, '  function [ result ] = lambdafile() \n\r');
    fprintf(fID, '  result = %f; \n', lambda);
    
    fprintf(fID, 'end \n\r');
    fclose(fID);  

end

