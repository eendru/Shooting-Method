function [ gF ] = computepartialgradient( F, dimension )
%computepartialgradient return partial gradient of functional
%   
     
    %symbol_v = sym('v', [1 dim]);
    symbol_w = sym('w', [1 dimension]);
    %symbol_vw = [symbol_v symbol_w];
    gF = gradient(F, symbol_w);
    

end

