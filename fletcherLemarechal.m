function alpha = fletcherLemarechal(f, grad_f, x, d, alphaMin, alphaMax, beta1, beta2)
    % Algorithme de Fletcher-Lemaréchal pour la recherche de pas

    alphaL = alphaMin;
    alphaR = alphaMax;
    alpha = (alphaL + alphaR) / 2;

    while true
        % Conditions de Wolfe
        if cost_function(x(1) + alpha * d, x(2) + alpha * d) > cost_function(x(1), x(2)) + beta1 * alpha * (gradient_cost(x(1), x(2))' * d)
            alphaR = alpha;
        elseif grad_f(x(1) + alpha * d, x(2) + alpha * d)' * d < beta2 * grad_f(x(1), x(2))' * d
            alphaL = alpha;
        else
            break;
        end
        alpha = (alphaL + alphaR) / 2;
    end
end