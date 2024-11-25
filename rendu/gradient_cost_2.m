function [gx, gy] = gradient_cost_2(cx, cy, sigma)
    % Chargement des points mesurés
    load('measured_points.mat');
    
    % Définition de la constante R et sigma
    R = 1.5;
    % sigma = 1;

    % Initialisation des variables
    n = size(xi, 1); % Nombre de points
    gx = 0;         % Gradient selon cx
    gy = 0;         % Gradient selon cy

    % Boucle sur chaque point
    for i = 1:n
        % Coordonnées du point
        Di = sqrt((xi(i) - cx)^2 + (yi(i) - cy)^2); % Distance au centre
        
        % Calcul de diff et denom
        diff = Di - R; % D_i - R
        denom = sigma^2 * (1 + (diff^2) / sigma^2); % Dénominateur commun
        
        % Contribution au gradient
        gx = gx + (2 * diff * (cx - xi(i))) / (Di * denom);
        gy = gy + (2 * diff * (cy - yi(i))) / (Di * denom);
    end
end
