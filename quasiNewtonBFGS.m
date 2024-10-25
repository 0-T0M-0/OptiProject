function center = quasiNewtonBFGS(f, grad_f, x0, maxIter)
    % f : fonction coût
    % grad_f : gradient de la fonction coût
    % x0 : estimation initiale du centre
    % maxIter : nombre maximum d'itérations

    tol = 1e-6;  % Tolérance pour l'arrêt
    n = length(x0);
    H = eye(n);  % Initialisation de l'approximation de l'inverse de la hessienne
    x = x0;

    for k = 1:maxIter
        grad = grad_f(x(1), x(2));  % Calcul du gradient
        if norm(grad) < tol
            break;
        end

        % Calcul de la direction de descente
        d = -H * grad;

        % Recherche linéaire avec la méthode de Fletcher-Lemaréchal
        alpha = fletcherLemarechal(f, grad_f, x, d, 1e-3, 1, 0.1, 0.9);

        % Mise à jour de la position
        x_next = x + alpha * d;

        % Mise à jour des variables pour BFGS
        s = x_next - x;
        y = grad_f(x_next(1), x_next(2)) - grad;
        
        % Mise à jour de l'approximation de l'inverse de la hessienne H avec BFGS
        if s' * y > 0  % Condition pour garantir que H reste définie positive
            rho = 1 / (y' * s);
            H = (eye(n) - rho * (s * y')) * H * (eye(n) - rho * (y * s')) + rho * (s * s');
        end

        % Mise à jour pour l'itération suivante
        x = x_next;
    end
    
    center = x;
end