function alpha = fletcherLemarechal(f, grad_f, x, d, c1, c2, alpha_init, beta)
    % Recherche linéaire selon les conditions de Wolfe (Fletcher-Lemaréchal)
    % f       : fonction coût
    % grad_f  : gradient de la fonction coût
    % x       : point de départ
    % d       : direction de descente
    % c1, c2  : paramètres des conditions de Wolfe
    % alpha_init : valeur initiale pour alpha
    % beta    : facteur de réduction

    alpha = alpha_init;
    maxIter = 20;

    for i = 1:maxIter
        % Évaluer la fonction coût et son gradient
        f_x_alpha = f(x(1) + alpha * d(1), x(2) + alpha * d(2));
        grad_x = grad_f(x(1), x(2));
        f_x = f(x(1), x(2));
        
        % Condition de Wolfe 1 : Sufficient decrease
        if f_x_alpha > f_x + c1 * alpha * (grad_x' * d)
            alpha = alpha * beta;  % Réduction de alpha
        else
            % Condition de Wolfe 2 : Curvature condition
            grad_f_x_alpha = grad_f(x(1) + alpha * d(1), x(2) + alpha * d(2));
            if grad_f_x_alpha' * d < c2 * (grad_x' * d)
                alpha = alpha / beta;  % Augmentation de alpha
            else
                break;  % Les deux conditions de Wolfe sont satisfaites
            end
        end
    end
end    