function [ A ] = getdisturbedmatrixproperties( dimension )
%GETDISTURBEDMATRIXPROPERTIES Get distribure matrix

    info_str = sprintf('dimension = %d', dimension);
    option.Resize = 'on';
    option.WindowStyle = 'normal';
    option.Interpreter = 'tex';
    
    dialogproperties = {'Input matrix'};
    defaultanswer = {' '};
    num_lines = 1;
    box = inputdlg(dialogproperties, info_str,  num_lines, defaultanswer, option);
    
    
    if ~isempty(box)
        A = box;
    else
        A = zeros(dimension);
    end


end

