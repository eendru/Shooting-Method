function [ center, radius] = getsphereproperties( dimension )
%GETSPHEREPROPERTIES get sphere properties - center and radius
%   Create input dialog


    info_str = sprintf('dimension = %d', dimension);
    option.Resize = 'off';
    option.WindowStyle = 'normal';
    option.Interpreter = 'tex';
    dialog_properties = {'Input coordinate:', 'Input radius:'};
    tmp = '';
    
    for i = 1 : 1 : dimension
        tmp = strcat(tmp, sprintf(' %d', 0));
    end
  
    default_answer = {tmp, '1'};
    
    numlines = 2;
    answer = inputdlg(dialog_properties, info_str, numlines, default_answer, option);
    
    if (~isempty(answer))
        [sphere_coord, status1] = str2num(answer{1});
        [sphere_radius, status2] = str2num(answer{2});
  
        input_size = size(sphere_coord);
  
        if ((~status1) || (input_size(2) ~= dimension))
            errordlg('Input error or error dimension', 'Coordinates of the ball')
        elseif ((~status2) || (sphere_radius < 0))
            errordlg('Input radius error', 'Radius of sphere')
        else
            radius = sphere_radius;
            center = sphere_coord;
        end
    else
        center = ones(1, dimension);
        radius = 1;
    end
end

