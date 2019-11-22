function [ result ] = wrfileaddcontgrad(add, Time, internalIter )
%WRFILEADDCONTGRAD Summary of this function goes here
%   Detailed explanation goes here
  left = Time(1);
  right = Time(end);
  step = abs(abs(Time(2)) - abs(Time(1)));
  N = round((right - left)/step + 1);
   
  result = sprintf('addcontgrad.m');
  msg = 'open';
  fd = -1;
  while fd < 0
      [fd, msg] = fopen(result, 'w');
  end
  
  fprintf(fd, 'function[result] = addcontgrad()\n');
  for i = 1 : 1 : N
    t = step*(i-1);
    iterat = internalIter;
    fprintf(fd, 'result(%d) = %G;\n', i, eval(add));    
  end
  fprintf(fd, 'end\n');    
  close_state = fclose(fd);
  
  
  while close_state ~= 0
      a = 'wait\n'
  end
  
  

end

