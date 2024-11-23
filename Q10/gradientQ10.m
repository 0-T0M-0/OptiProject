function grad = computeGradient(cx, cy, sigma, points, R)
    % Fonction qui calcule le gradient de C_TLS
    % 
    % Entrées :
    % - cx, cy : coordonnées du centre (scalaires)
    % - sigma : écart type (scalaire)
    % - points : matrice Nx2 où chaque ligne est un point (xi, yi)
    % - R : constante (scalaire)
    %
    % Sortie :
    % - grad : vecteur gradient [dC/dcx, dC/dcy]

    % Initialisation des variables
    n = size(points, 1);  % Nombre de points
    grad_cx = 0;          % Composante cx du gradient
    grad_cy = 0;          % Composante cy du gradient

    % Boucle sur les points
    for i = 1:n
        xi = points(i, 1); % Coordonnée x du point i
        yi = points(i, 2); % Coordonnée y du point i
        
        % Calcul de Di
        Di = sqrt((xi - cx)^2 + (yi - cy)^2);
        
        % Calcul des termes communs
        diff = Di - R; % D_i - R
        denom = sigma^2 * (1 + (diff^2) / sigma^2); % Dénominateur commun
        
        % Contribution au gradient selon cx
        grad_cx = grad_cx + (2 * diff * (cx - xi)) / (Di * denom);
        
        % Contribution au gradient selon cy
        grad_cy = grad_cy + (2 * diff * (cy - yi)) / (Di * denom);
    end

    % Gradient complet
    grad = [grad_cx, grad_cy];
end
