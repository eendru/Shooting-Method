function [result] = writeV0cont(Time, V0)
   left = Time(1);
   right = Time(end);
   step = abs(abs(Time(2)) - abs(Time(1)));
   N = round((right - left)/step + 1);
   
   result = 'Vkfile.m';
   msg = 'open vo cont'
   
   fd = -1;
   while fd < 0
      disp(msg)
      [fd, msg] = fopen(result, 'w');
   end
   
   fprintf(fd, 'function[result] = Vkfile()\n');
   
   if isnumeric(V0)  
       
    for i = 1 : 1 : N
       %t = step*(i-1);
      fprintf(fd, 'result(%d) = %G;\n', i, V0(i));    
    end
    
    
    fprintf(fd, 'end\n');    
    close_state = fclose(fd);
    fclose('all')
   
      while close_state ~= 0
        a = 'wait\n'
      end
      
      delay(1)
      res = V0file();
      while res(end) ~= V0(end)
         %disp('sex with files in Matlab')
         %res(end)
         %V0(end)
      end
      
   else 
     for i = 1 : 1 : N
       t = step*(i-1);
       fprintf(fd, 'result(%d) = %G;\n', i, eval(V0));    
     end
     fprintf(fd, 'end\n');    
     close_state = fclose(fd);
   
     while close_state ~= 0
       a = 'wait\n'
     end
  
   end
   

end