function [ filename ] = wrfilecontgrad( F, iterat)
%WRFILENUMGRAD return name of file with gradient
%   Detailed explanation goes here
    
    N = size(F); 
    N = N(2);
    
    filename = sprintf('partionalcontgrad.m');
    iterat = iterat/N;
    x = max(0,min(100*iterat,100));
    msg = sprintf('%0.1f', x);
    fID = -1;
    while fID < 0
      disp(msg)
      [fID, msg] = fopen(filename, 'w');
    end
 
   
    fprintf(fID, '  function [ pG ] = partionalcontgrad() \n\r');
    
   
    for i = 1 : 1 : N 
        fprintf(fID,  sprintf('pG(%d) = %G; \n' , i, F(i)));
    end
  
    fprintf(fID, 'end \n\r');
    close_state = fclose(fID);  
    
    while close_state ~= 0
        a = 'wait\n'
    end
    
end

