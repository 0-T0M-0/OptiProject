function iterates = steepest_descent_fletcher_lemarechal(cx_ini, cy_ini, max_iter_ini, alpha_ini)
    % Chargement des points mesurés
    load('measured_points.mat');
    R = 1.5;

    % Initialisation des variables
    cx = cx_ini; cy = cy_ini; % Point initial
    max_iter = max_iter_ini; % Nombre maximal d'itérations
    alpha = alpha_ini; % Pas initial

    % Pour le suivi des résultats
    iterates = [cx, cy]; % Liste des itérés
    cost_values = []; % Valeurs de la fonction de coût
    grad_norms = []; % Normes du gradient
    dist_iter = []; % Distance entre itérés
    dist_to_sol = []; % Distance à la solution

    % Définition d'une approximation de la solution (après 1000 itérations)
    [cx_sol, cy_sol] = approximate_solution(cx_ini, cy_ini, max_iter_ini, alpha_ini);

    % Boucle d'optimisation
    for k = 1:max_iter
        % Calcul du gradient
        [gx, gy] = gradient_cost(cx, cy);
        
        % Calcul de la norme du gradient
        grad_norm = norm([gx, gy]);
        
        % Recherche linéaire avec Fletcher-Lemaréchal
        alpha = fletcher_lemarechal_search(cx, cy, gx, gy, alpha);
        
        % Mise à jour des itérés
        cx_new = cx - alpha * gx;
        cy_new = cy - alpha * gy;
        
        % Stockage des résultats
        iterates = [iterates; cx_new, cy_new];
        cost_values = [cost_values, cost_function(cx_new, cy_new)];
        grad_norms = [grad_norms, grad_norm];
        dist_iter = [dist_iter, norm([cx_new - cx, cy_new - cy])];
        dist_to_sol = [dist_to_sol, norm([cx_new - cx_sol, cy_new - cy_sol])];
        
        % Mise à jour de cx et cy pour la prochaine itération
        cx = cx_new;
        cy = cy_new;
  
    end

    % Affichage des résultats
    figure;
    subplot(2, 2, 1);
    plot(iterates(:, 1), iterates(:, 2), '-o');
    title('Suite des itérés dans le plan (cx, cy)');
    xlabel('cx'); ylabel('cy');
    
    subplot(2, 2, 2);
    plot(1:length(cost_values), cost_values);
    title('Évolution de la fonction de coût');
    xlabel('Itération'); ylabel('Coût');
    
    subplot(2, 2, 3);
    plot(1:length(grad_norms), grad_norms);
    title('Évolution de la norme du gradient');
    xlabel('Itération'); ylabel('Norme du gradient');
    
    subplot(2, 2, 4);
    plot(1:length(dist_iter), dist_iter);
    title('Distance entre deux itérés successifs');
    xlabel('Itération'); ylabel('Distance');
    
    % Distance à la solution
    figure;
    plot(1:length(dist_to_sol), dist_to_sol);
    title('Distance à la solution approximée');
    xlabel('Itération'); ylabel('Distance à la solution');
end