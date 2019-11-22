function [ alpha, beta ] = getboxproperties( dimension )
%GETPARALLELEPIPEDPROPERTIES get box properties - alpha and beta
%   Create input dialog
    
    
    info_str = sprintf('dimension = %d', dimension);
    option.Resize = 'on';
    option.WindowStyle = 'normal';
    option.Interpreter = 'tex';
    
    dialogproperties = {'alpha < x', 'x < beta'};
    defaultanswer = {' ', ' '};
    num_lines = 1;
    box = inputdlg(dialogproperties, info_str,  num_lines, defaultanswer, option);
    
    
    if ~isempty(box)
        [alpha, status] = str2num(box{1});
        if ~status
            alpha = (-1) * ones(1, dimension);
        end
        [beta, status] = str2num(box{2});
        if ~status
            beta =  ones(1, dimension);
        end
    else
        alpha = (-1) * ones(1, dimension);
        beta =  ones(1, dimension);
    end
    


end

