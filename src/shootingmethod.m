function [ vk ] = shootingmethod( tag, dimension, v0, iter_numbers,  alpha, radius, center, box_alpha, box_beta, selectF, w0 )
%SHOOTINGMETHOD Compute vk after iter_numbers
    
    vk = v0;
    fprintf('Start method \n')
    fprintf('With N = %d \n\n', iter_numbers)
    
    %% custom functional 
    if selectF == 4
        %% Sphere
        if (tag == 1)
            % Maybe v0 not in SPHERE
            tic;
            for i = 1 : 1 : iter_numbers

                grad = partionalgradcustom (vk, vk, dimension, 0.01);
                wk = project2sphere (vk-alpha(i) * grad, radius, center);
                % choose hyperplane
                c2 = (vk - wk);
                alpha2 = dot((vk-wk)/2, vk+wk);
                c1 = (v0 - vk);
                alpha1 = dot(v0-vk, vk);
                nabla_l1 = norm(c2)^2 * (dot(c1, v0) - alpha1) - dot(c1, c2) * (dot(c2, v0) - alpha2);
                nabla_l2 = norm(c1)^2 * (dot(c2, v0) - alpha2) - dot(c1, c2) * (dot(c1, v0) - alpha1);
                nabla = norm(c1)^2 * norm(c2)^2 - dot(c1, c2)^2;

                if (nabla == 0) % c1 || c2 and same direction
                    vk = project2hyperplane(v0, c2, alpha2); % project to ck
                else
                    if (nabla_l1 >= 0 && nabla_l2 >= 0)
                        mu1 = nabla_l1/nabla;
                        mu2 = nabla_l2/nabla;
                        vk = v0 - mu1*c1 - mu2*c2;
                    elseif nabla_l1 >= 0 && nabla_l2 < 0
                            vk = v0 - c1 * (dot(c1, v0) - alpha1)/(norm(c1)^2);
                    elseif nabla_l1 < 0 && nabla_l2 >= 0
                            vk = v0 - c2 * (dot(c2, v0) - alpha2)/(norm(c2)^2);
                    elseif nabla_l1 <= 0 && nabla_l2 <=0
                        fprintf('===== Something strange =====\n\n');
                    end
                end
            end
            run_time = toc;
            fn = generatereport(v0, iter_numbers, alpha, 'custom F(v, w)', 0, 'sphere', run_time, vk);
            open(fn)

        %% Box 
        elseif (tag == 2)
             tic;
             for i = 1 : 1 : iter_numbers

                grad = partionalgradcustom (vk, vk, dimension, 0.01);
                wk = project2box (vk-alpha(i) * grad, box_alpha, box_beta, 'discrete');
                % choose hyperplane

                c2 = (vk - wk);
                alpha2 = dot((vk-wk)/2, vk+wk);
                c1 = (v0 - vk);
                alpha1 = dot(v0-vk, vk);

                nabla_l1 = norm(c2)^2 * (dot(c1, v0) - alpha1) - dot(c1, c2) * (dot(c2, v0) - alpha2);
                nabla_l2 = norm(c1)^2 * (dot(c2, v0) - alpha2) - dot(c1, c2) * (dot(c1, v0) - alpha1);
                nabla = norm(c1)^2 * norm(c2)^2 - dot(c1, c2)^2;


                if (nabla == 0) % c1 || c2 and same direction
                    vk = project2hyperplane(v0, c2, alpha2); % project to ck
                else
                    if (nabla_l1 >= 0 && nabla_l2 >= 0)
                        mu1 = nabla_l1/nabla;
                        mu2 = nabla_l2/nabla;
                        vk = v0 - mu1*c1 - mu2*c2;
                    elseif nabla_l1 >= 0 && nabla_l2 < 0
                            vk = v0 - c1 * (dot(c1, v0) - alpha1)/(norm(c1)^2);
                    elseif nabla_l1 < 0 && nabla_l2 >= 0
                            vk = v0 - c2 * (dot(c2, v0) - alpha2)/(norm(c2)^2);
                    elseif nabla_l1 <= 0 && nabla_l2 <=0
                        fprintf('===== Something strange =====\n\n');
                    end
                end
             end
             run_time = toc;
            
             
            fn = generatereport(v0, iter_numbers, alpha, 'custom F(v, w)', 0, 'box', run_time, vk);
            open(fn)
        end
        
        
    elseif selectF == 2
     %% this stuff for <Av,w>+||v-w||      
        
        v = cell(dimension, 1);
        for i = dimension: -1 : 1
            v{i, 1} = sprintf('v(%d)', i);	
        end	
        
        disturbedA = disturbedmatrixfile(); % it's matrix with basicA !!
        Av = multiplycellbyvector(disturbedA, v);
        %%   check  v0
        lambda = lambdafile();
        v_w0 = by2vectors(v, w0, 'minus', 1*lambda, 1*lambda);
        Av_v_w0 = by2vectors(Av, v_w0, 'plus', 1, 2);
        wrfilenumgrad(Av_v_w0, dimension);
             
        
        if (tag == 1)    
            tic;  
            for i = 1 : 1 : iter_numbers

                grad = partionalgrad(vk, vk, dimension, i);
                wk = project2sphere (vk-alpha(i) * grad, radius, center);
                    % choose hyperplane

                    c2 = (vk - wk);
                    alpha2 = dot((vk-wk)/2, vk+wk);
                    c1 = (v0 - vk);
                    alpha1 = dot(v0-vk, vk);

                    nabla_l1 = norm(c2)^2 * (dot(c1, v0) - alpha1) - dot(c1, c2) * (dot(c2, v0) - alpha2);
                    nabla_l2 = norm(c1)^2 * (dot(c2, v0) - alpha2) - dot(c1, c2) * (dot(c1, v0) - alpha1);
                    nabla = norm(c1)^2 * norm(c2)^2 - dot(c1, c2)^2;
                    
                    if (nabla == 0) % c1 || c2 and same direction
                        vk = project2hyperplane(v0, c2, alpha2); % project to ck
                    else
                        if (nabla_l1 >= 0 && nabla_l2 >= 0)
                            mu1 = nabla_l1/nabla;
                            mu2 = nabla_l2/nabla;
                            vk = v0 - mu1*c1 - mu2*c2;
                        elseif nabla_l1 >= 0 && nabla_l2 < 0
                                vk = v0 - c1 * (dot(c1, v0) - alpha1)/(norm(c1)^2);
                        elseif nabla_l1 < 0 && nabla_l2 >= 0
                                vk = v0 - c2 * (dot(c2, v0) - alpha2)/(norm(c2)^2);
                        elseif nabla_l1 <= 0 && nabla_l2 <=0
                            fprintf('===== Something strange =====\n\n');
                        end
                    end
            end
            run_time = toc
            vk
            fn = generatereport(v0, iter_numbers, alpha, '<Av, w>', basicmatrixfile(dimension), 'sphere', run_time, vk);
            open(fn)
        
        elseif tag == 2
            tic;
            fplt = fopen('info.txt', 'w');
            
            
            n1 = box_alpha(1) : 0.01 : box_beta(1);
            dataQk = zeros(length(n1), iter_numbers);
            dataCk = zeros( length(n1), iter_numbers);
            for i = 1 : 1 : iter_numbers
                
                grad = partionalgrad(vk, vk, dimension, i);
                wk = project2box (vk-alpha(i) * grad, box_alpha, box_beta, 'discrete');
                    % choose hyperplane
                    c2 = (vk - wk);%Ck
                    alpha2 = dot((vk-wk)/2, vk+wk);
                    
                    c1 = (v0 - vk); %Qk
                    alpha1 = dot(v0-vk, vk);

                    nabla_l1 = norm(c2)^2 * (dot(c1, v0) - alpha1) - dot(c1, c2) * (dot(c2, v0) - alpha2);
                    nabla_l2 = norm(c1)^2 * (dot(c2, v0) - alpha2) - dot(c1, c2) * (dot(c1, v0) - alpha1);
                    nabla = norm(c1)^2 * norm(c2)^2 - dot(c1, c2)^2;
                    
                    
                
                
                if (alpha1 ~=0)
                   
                   u1_1 = box_alpha(1) : 0.01:box_beta(1);
                   u1_2 = (alpha1/c1(2)) - (c1(1)/c1(2))*u1_1;
                   
                   dataQk(:, i) = u1_1;
                   dataQk(:, i) = u1_2;
                   %hold on;
                   %plot(u1, u2);
                end
                 
                if (alpha2 ~=0)
                    
                   u2_1 = box_alpha(1) : 0.01:box_beta(1);
                   u2_2 = (alpha2/c2(2)) - (c2(1)/c2(2))*u2_1;
                   
                   
                   dataCk(:, i) = u2_1;
                   dataCk(:, i) = u2_2;
                   
                   %hold on;
                   %plot(u1, u2);
                end
                



                    if (nabla == 0) % c1 || c2 and same direction
                        vk = project2hyperplane(v0, c2, alpha2); % project to ck
                    else
                        if (nabla_l1 >= 0 && nabla_l2 >= 0)
                            mu1 = nabla_l1/nabla;
                            mu2 = nabla_l2/nabla;
                            vk = v0 - mu1*c1 - mu2*c2;
                        elseif nabla_l1 >= 0 && nabla_l2 < 0
                                vk = v0 - c1 * (dot(c1, v0) - alpha1)/(norm(c1)^2);
                        elseif nabla_l1 < 0 && nabla_l2 >= 0
                                vk = v0 - c2 * (dot(c2, v0) - alpha2)/(norm(c2)^2);
                        elseif nabla_l1 <= 0 && nabla_l2 <=0
                            fprintf('===== Something strange =====\n\n');
                        end
                    end
                    fprintf(fplt, 'vk = %f\n\n', vk);
                
                    
            end
            run_time = toc
            fclose(fplt); 
            vk
            fn = generatereport(v0, iter_numbers, alpha, '<Av, w>', basicmatrixfile(dimension), 'box', run_time, vk);
            open(fn)
            
            %T1 = cell2table(dataQk);
            dlmwrite('Qk.txt', dataQk);
            
            
            %T2 = cell2table(dataCk);
            dlmwrite('Ck.txt', dataCk);
        end
    elseif selectF == 3
        %% this stuff for <Av, w> + 2*eps/(1 + ||v-w||)
        %% p(v) = 1/(1+||v-w||) - number
                  
        v = cell(dimension, 1);
        for i = dimension: -1 : 1
            v{i, 1} = sprintf('v(%d)', i);	
        end	
        
        %% eps
        lambda = lambdafile();
        
        A = basicmatrixfile(dimension);  % integer or double
        Av = multiplycellbyvector(2*lambda*A, v); % vector-cell 
        Apv = addpvtomatrix(Av, dimension);
        
        w0eps = 2*lambda*w0;
        
        pv = addpvtovector(w0eps, dimension);
        AWpv = by2vectors(Apv, pv, 'plus', 1, 1);
        wrfilenumgrad_pv(AWpv, dimension);
        
        
        if (tag == 1)
            tic;
            for i = 1 : 1 : iter_numbers
                grad = partionalgrad(vk, vk, dimension, i, w0');
                wk = project2sphere (vk-alpha(i) * grad, box_alpha, box_beta);
                    % choose hyperplane

                    c2 = (vk - wk);
                    alpha2 = dot((vk-wk)/2, vk+wk);
                    c1 = (v0 - vk);
                    alpha1 = dot(v0-vk, vk);

                    nabla_l1 = norm(c2)^2 * (dot(c1, v0) - alpha1) - dot(c1, c2) * (dot(c2, v0) - alpha2);
                    nabla_l2 = norm(c1)^2 * (dot(c2, v0) - alpha2) - dot(c1, c2) * (dot(c1, v0) - alpha1);
                    nabla = norm(c1)^2 * norm(c2)^2 - dot(c1, c2)^2;

                    if (nabla == 0) % c1 || c2 and same direction
                        vk = project2hyperplane(v0, c2, alpha2); % project to ck
                    else
                        if (nabla_l1 >= 0 && nabla_l2 >= 0)
                            mu1 = nabla_l1/nabla;
                            mu2 = nabla_l2/nabla;
                            vk = v0 - mu1*c1 - mu2*c2;
                        elseif nabla_l1 >= 0 && nabla_l2 < 0
                                vk = v0 - c1 * (dot(c1, v0) - alpha1)/(norm(c1)^2);
                        elseif nabla_l1 < 0 && nabla_l2 >= 0
                                vk = v0 - c2 * (dot(c2, v0) - alpha2)/(norm(c2)^2);
                        elseif nabla_l1 <= 0 && nabla_l2 <=0
                            fprintf('===== Something strange =====\n\n');
                        end
                    end
            end
            run_time = toc;
            fn = generatereport(v0, iter_numbers, alpha, '<Av, w>+lambda/(1+||w-w0||)^2', basicmatrixfile(dimension), 'sphere', run_time, vk);
            open(fn)
            
        elseif (tag == 2)
            tic;
            for i = 1 : 1 : iter_numbers
                grad = partionalgrad(vk, vk, dimension, i, w0');
                wk = project2box (vk-alpha(i) * grad, box_alpha, box_beta, 'discrete');
                    % choose hyperplane

                    c2 = (vk - wk);
                    alpha2 = dot((vk-wk)/2, vk+wk);
                    c1 = (v0 - vk);
                    alpha1 = dot(v0-vk, vk);

                    nabla_l1 = norm(c2)^2 * (dot(c1, v0) - alpha1) - dot(c1, c2) * (dot(c2, v0) - alpha2);
                    nabla_l2 = norm(c1)^2 * (dot(c2, v0) - alpha2) - dot(c1, c2) * (dot(c1, v0) - alpha1);
                    nabla = norm(c1)^2 * norm(c2)^2 - dot(c1, c2)^2;

                    if (nabla == 0) % c1 || c2 and same direction
                        vk = project2hyperplane(v0, c2, alpha2); % project to ck
                    else
                        if (nabla_l1 >= 0 && nabla_l2 >= 0)
                            mu1 = nabla_l1/nabla;
                            mu2 = nabla_l2/nabla;
                            vk = v0 - mu1*c1 - mu2*c2;
                        elseif nabla_l1 >= 0 && nabla_l2 < 0
                                vk = v0 - c1 * (dot(c1, v0) - alpha1)/(norm(c1)^2);
                        elseif nabla_l1 < 0 && nabla_l2 >= 0
                                vk = v0 - c2 * (dot(c2, v0) - alpha2)/(norm(c2)^2);
                        elseif nabla_l1 <= 0 && nabla_l2 <=0
                            fprintf('===== Something strange =====\n\n');
                        end
                    end
            end
            run_time = toc;
            fn = generatereport(v0, iter_numbers, alpha, '<Av, w>+lambda/(1+||w-w0||)^2', basicmatrixfile(dimension), 'box', run_time, vk);
            open(fn)   
        end
    end

end

