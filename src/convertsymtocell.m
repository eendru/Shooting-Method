function [ cellgF ] = convertsymtocell( gF, graddim )
%CONVERTSYMTOCELL convert gradient from sym form to cell form
%   Also add bracket's
    
    for i = graddim : -1 : 1
        gF= subs((gF), sprintf('v%d', i), sprintf('v(%d)', i));	
        gF= subs((gF), sprintf('w%d', i), sprintf('w(%d)', i));	
    end	
    [mgradsize, ~] = size(gF);
 
    cellgF = cell(mgradsize, 1);
    for i = 1 : 1 : mgradsize
        cellgF{i} = char(gF(i, 1));
    end

end

