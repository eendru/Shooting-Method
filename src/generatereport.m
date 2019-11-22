function [ filename ] = generatereport(v0, N, alpha, typefunctional, basicA, set, elapsed_time, vk)
%GENERATEREPORT Summary of this function goes here
%   Detailed explanation goes here



    
    x = rand(1, 1);	
    a = 1; b = 200;	% задаем границы интервала 
    y = a + (b-a)*x;
    
    dimension = size(basicA, 1);
    time_info = clock;
    filename = sprintf('shooting_report_%d_%d_%d_%d_%d_%d.txt', time_info(1), time_info(2), time_info(3), time_info(4), time_info(5), y);
    filename = fullfile('report', filename);
    fid = fopen(filename, 'w');
    fprintf (fid, '========== Shooting method report ========== \n\r');
    fprintf (fid, 'Number of iterations %d \n\r', N);
    fprintf (fid, 'Alpha ');
    for i = 1 : 1 : size(alpha, 2)
        fprintf (fid, ' %f ', alpha(i));
    end
    
    fprintf (fid, '\nV0 \n');
    for i = 1 : 1 : dimension
        fprintf (fid, ' \t %f\n\r', v0(i));
    end
    
    fprintf (fid, 'A  \n\r');
    for i = 1 : 1 : dimension
            for j = 1 : 1 : dimension
                fprintf (fid, ' \t %f ', basicA(i, j));
            end
            fprintf (fid, ' \n\r');
    end
    
    fprintf (fid, 'disturbed matrix \n\r');
    disturbedA = disturbedmatrixfile();
    
    for i = 1 : 1 : dimension
            for j = 1 : 1 : dimension
                if isnumeric (disturbedA{i, j})
                    fprintf (fid, ' \t %f ', disturbedA{i, j});
                else
                    fprintf (fid, ' \t %s ', char(disturbedA{i, j}));
                end
            end
            fprintf (fid, ' \n\r');
    end

    
    
    fprintf (fid, 'vk  \n');
    fprintf (fid, '===============================\n');
    for i = 1 : 1 : dimension
        fprintf (fid, '\t|| ');
        fprintf (fid, '%f ', vk(i));
        fprintf (fid, '||\n');
    end
    fprintf (fid, '===============================\n');
    
    
    fprintf (fid, '\nSet  %s \n\r\n\n', set);
    fprintf (fid, 'Functional %s\n\r', typefunctional);
    fprintf (fid, '\n\nElapsed time: %f \n\r', elapsed_time);
    fprintf(fid, '%d-%d-%d  %d:%d\n\r\0', time_info(1), time_info(2), time_info(3), time_info(4), time_info(5));
    
    fclose(fid);


end

