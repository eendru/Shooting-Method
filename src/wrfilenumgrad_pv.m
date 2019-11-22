function [ filename ] = wrfilenumgrad_pv( F, dimension )
%WRFILENUMGRAD return name of file with gradient
%   Detailed explanation goes here

 
    
    filename = sprintf('partionalgrad.m');
    fID = fopen(filename, 'w');
   
    fprintf(fID, '  function [ pG ] = partionalgrad(v, w, dimension, k,w0) \n\r');
    fprintf(fID, '  pG = zeros( dimension , 1);\n\r');
    
    for i = 1 : 1 : dimension 
       
        fprintf(fID,  sprintf('pG(%d) = %s; \n' , i, F{i}));
    end
  
    fprintf(fID, 'end \n\r');
    fclose(fID);  

end

