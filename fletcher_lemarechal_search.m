function alpha = fletcher_lemarechal_search(cx, cy, gx, gy, alpha_init)
    load("measured_points.mat");
    R = 1.5;

    % Implémentation de l'algorithme de Fletcher-Lemaréchal pour la recherche de pas
    c1 = 1e-4; c2 = 0.9; % Paramètres de Wolfe
    alpha = alpha_init; % Initialisation du pas
    max_search_iter = 100;
    
    for i = 1:max_search_iter
        % Calcul de la condition de Wolfe 1
        if cost_function(cx - alpha * gx, cy - alpha * gy) <= ...
           cost_function(cx, cy) - c1 * alpha * (gx^2 + gy^2)
            % Calcul de la condition de Wolfe 2
            if - (gx^2 + gy^2) <= -c2 * norm([gx, gy])
                break;
            end
        end
        alpha = alpha / 2; % Diminution du pas
    end
end