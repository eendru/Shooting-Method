function [ result] = addpvtovector(w, dimension)
 

  result = cell(size(w));
  
  for i = 1 : 1 : dimension
          if isnumeric(w(i))
              result{i, 1} = sprintf('%f/pvfile(v, w0)', w(i));
          else
              result{i, 1} = sprintf('%s/pvfile(v, w0)', w(i));
          end
      
  end
  
  