function [result] = writeW0cont(Time, W0)
   left = Time(1);
   right = Time(end);
   step = abs(abs(Time(2)) - abs(Time(1)));
   N = round ((right - left)/step + 1);
   
   filename = 'W0file.m';
   fd = fopen(filename, 'w');
   fprintf(fd, 'function[result] = W0file()\n');
   if isnumeric(W0)  
    for i = 1 : 1 : N
       %t = step*(i-1);
      fprintf(fd, 'result(%d) = %f;\n', i, W0(i));    
    end
   else 
     for i = 1 : 1 : N
       t = step*(i-1);
       fprintf(fd, 'result(%d) = %f;\n', i, eval(W0));    
     end
   end
   fprintf(fd, 'end\n');    
   fclose(fd);

end