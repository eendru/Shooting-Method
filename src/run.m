%% Initialization
%Init scipt
warning off backtrace
clear ; close all; clc;
clearvars -global
clearvars vk
if (exist('partionalgrad.m', 'file'))
        warning('Maybe you need to restart')
        
end

if (exist('basicmatrixfile.m', 'file'))
        warning('Maybe you need to restart')
end
    
if (exist('partionalcontgrad.m', 'file'))
        warning('Maybe you need to restart')
        %delete('partionalcontgrad.m')
end

if (exist('addcontgrad.m', 'file'))
        warning('Maybe you need to restart')
        %delete('addcontgrad.m')
end

shootingMethod_v1