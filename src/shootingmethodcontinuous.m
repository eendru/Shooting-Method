function [vk] = shootingmethodcontinuous(v0_i, w0_i, iter_numbers, Time, alpha, tag, radius, center, box_alpha, box_beta)
  %% continuous variant of shooting method L_2 [0, T]
  vk = v0_i;
  fprintf('===== Start continuos method ======\n');
  w0 = w0_i;
  v0 = v0_i;
    %%
      left = Time(1);
      right = Time(end);
      step = abs(abs(Time(2)) - abs(Time(1)));
      N = round((right - left)/step + 1);
    %%
 
  %% Sphere
  
  if (tag == 1)
    
    h = waitbar(0, 'Start process');
    for i = 1 : 1 : iter_numbers
      
      Av_v_w0 = getAv(vk, Time) + 2*(vk-w0);
      grad = Av_v_w0;
      
      tmp = []; 
      add = 'sin(iterat*t)';
      for ij = 1 : 1 : N
        t = step*(ij-1);
        iterat = i;
        tmp(ij) = eval(add);    
      end
      
      grad = grad + 1/i * tmp;
      specalpha = 1/sqrt(i);
      grad = grad + specalpha * vk;
      
      
      %%
        wk = project2spherecont (vk-alpha * grad, radius, center, left, right, N);
        
                % choose hyperplane
                c2 = (vk - wk);
                alpha2 = dot_l2((vk-wk)/2, vk+wk, left, right, N);
                c1 = (v0 - vk);
                alpha1 = dot_l2(v0-vk, vk, left, right, N);
                

                nabla_l1 = norm_l2(c2, left, right, N)^2 * (dot_l2(c1, v0, left, right, N) - alpha1) - dot_l2(c1, c2, left, right, N) * (dot_l2(c2, v0, left, right, N) - alpha2);
                nabla_l2 = norm_l2(c1, left, right, N)^2 * (dot_l2(c2, v0, left, right, N) - alpha2) - dot_l2(c1, c2, left, right, N) * (dot_l2(c1, v0, left, right, N) - alpha1);
                nabla = norm_l2(c1, left, right, N)^2 * norm_l2(c2, left, right, N)^2 - dot_l2(c1, c2, left, right, N)^2;

                if (nabla == 0) % c1 || c2 and same direction
                    vk = project2hyperplanecont(v0, c2, alpha2, left, right, N); % project to ck
                else
                    if (nabla_l1 >= 0 && nabla_l2 >= 0)
                        mu1 = nabla_l1/nabla;
                        mu2 = nabla_l2/nabla;
                        vk = v0 - mu1*c1 - mu2*c2;
                    elseif nabla_l1 >= 0 && nabla_l2 < 0
                            vk = v0 - c1 * (dot_l2(c1, v0, left, right, N) - alpha1)/(norm_l2(c1, left, right, N)^2);
                    elseif nabla_l1 < 0 && nabla_l2 >= 0
                            vk = v0 - c2 * (dot_l2(c2, v0, left, right, N) - alpha2)/(norm_l2(c2, left, right, N)^2);
                    elseif nabla_l1 <= 0 && nabla_l2 <=0
                        fprintf('===== Something strange =====\n\n');
                    end
                end  
     
      waitbar(i/iter_numbers)
    end
    close(h)
  
    
  %%                                          Box
  elseif tag == 2
    

    h = waitbar(0, 'Start process');
    for i = 1 : 1 : iter_numbers
       
     
      Av_v_w0 = getAv(vk, Time) + 2*(vk-w0);
      grad = Av_v_w0;
      
      tmp = []; 
      add = 'sin(iterat*t)';
      for ij = 1 : 1 : N
        t = step*(ij-1);    
        iterat = i;
        tmp(ij) = eval(add);    
      end
      
      grad = grad + 1/i * tmp;
      specalpha = 1/sqrt(i);
      grad = grad;% + specalpha * vk;   
      
      wk = project2boxcont (vk-alpha * grad, box_alpha, box_beta);  
      % choose hyperplane
                % choose hyperplane
                c2 = (vk - wk);
                alpha2 = dot_l2((vk-wk)/2, vk+wk, left, right, N);
                c1 = (v0 - vk);
                alpha1 = dot_l2(v0-vk, vk, left, right, N);

                nabla_l1 = norm_l2(c2, left, right, N)^2 * (dot_l2(c1, v0, left, right, N) - alpha1) - dot_l2(c1, c2, left, right, N) * (dot_l2(c2, v0, left, right, N) - alpha2);
                nabla_l2 = norm_l2(c1, left, right, N)^2 * (dot_l2(c2, v0, left, right, N) - alpha2) - dot_l2(c1, c2, left, right, N) * (dot_l2(c1, v0, left, right, N) - alpha1);
                nabla = norm_l2(c1, left, right, N)^2 * norm_l2(c2, left, right, N)^2 - dot_l2(c1, c2, left, right, N)^2;

                if (nabla == 0) % c1 || c2 and same direction
                    vk = project2hyperplanecont(v0, c2, alpha2, left, right, N); % project to ck
                else
                    if (nabla_l1 >= 0 && nabla_l2 >= 0)
                        mu1 = nabla_l1/nabla;
                        mu2 = nabla_l2/nabla;
                        vk = v0 - mu1*c1 - mu2*c2;
                    elseif nabla_l1 >= 0 && nabla_l2 < 0
                            vk = v0 - c1 * (dot_l2(c1, v0, left, right, N) - alpha1)/(norm_l2(c1, left, right, N)^2);
                    elseif nabla_l1 < 0 && nabla_l2 >= 0
                            vk = v0 - c2 * (dot_l2(c2, v0, left, right, N) - alpha2)/(norm_l2(c2, left, right, N)^2);
                    elseif nabla_l1 <= 0 && nabla_l2 <=0
                        fprintf('===== Something strange =====\n\n');
                    end
                end  
      
      waitbar(i/iter_numbers)
    end
    close(h)   
  end
  
  figure;
  
  %[tode, vkode] = ode45(@difftmp, Time, (2/3)*sin(1))
  plot(Time, vk)
  xlabel('t')
  ylabel('v(t)')

end