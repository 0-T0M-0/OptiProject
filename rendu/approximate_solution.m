function [cx_sol, cy_sol] = approximate_solution(cx_ini, cy_ini, max_iter, alpha_ini)
    cx_sol = cx_ini; % Point initial
    cy_sol = cy_ini;
    alpha = alpha_ini;
    for i = 1:max_iter
        [gx, gy] = gradient_cost(cx_sol, cy_sol);
        grad_norm = norm([gx, gy]);
        if grad_norm < 1e-6 % Condition d'arrêt si le gradient est proche de 0
            break;
        end
        alpha = fletcher_lemarechal_search(cx_sol, cy_sol, gx, gy, alpha);
        cx_sol = cx_sol - alpha * gx;
        cy_sol = cy_sol - alpha * gy;
    end
end
