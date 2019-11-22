function [ result] = addpvtomatrix(A, dimension)
 

  result = cell(size(A));
  dim1 = size(A, 1);
  dim2 = size(A, 2);
  
  for i = 1 : 1 : dim1
      for j = 1 : 1 : dim2
          if isnumeric(A(i, j))
              result{i, j} = sprintf('%f/pvfile(v, w0)', (A(i, j)));
          else
              result{i, j} = sprintf('%s/pvfile(v, w0)', char(A(i, j)));
          end
      end
  end
  
  
  