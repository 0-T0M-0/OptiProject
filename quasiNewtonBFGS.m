function [center, iterates, cost_values, grad_norms, dist_iter] = quasiNewtonBFGS(f, grad_f, x0, maxIter)
    tol = 1e-6;
    n = length(x0);
    H = eye(n);  % Initial Hessian approximation
    x = x0(:);   % Initial point as column vector

    iterates = x';
    cost_values = [];
    grad_norms = [];
    dist_iter = [];

    for k = 1:maxIter
        [gradx, grady] = grad_f(x(1), x(2));
        cost = f(x(1), x(2));

        % Debugging: Print gradient
        disp(['Gradient at iteration ', num2str(k), ':']);
        disp(gradx);
        disp(grady);

        cost_values = [cost_values, cost];
        grad_norms = [grad_norms, norm([gradx, grady])];

        if norm([gradx, grady]) < tol
            break;
        end

        % Compute direction of descent
        d = -H * [gradx; grady];

        % Debugging: Print direction of descent
        disp(['Direction of Descent at iteration ', num2str(k), ':']);
        disp(d);

        % Line search
        alpha = fletcherLemarechal(f, grad_f, x, d, 1e-4, 0.9, 0.1, 0.5);
        disp(['Step size alpha at iteration ', num2str(k), ': ', num2str(alpha)]);

        % Update position
        x_next = x + alpha * d;

        % Debugging: Print updated x
        disp(['Updated x at iteration ', num2str(k), ':']);
        disp(x_next);

        dist_iter = [dist_iter, norm(x_next - x)];

        % Update Hessian approximation
        s = x_next - x;
        y = grad_f(x_next(1), x_next(2)) - [gradx; grady];

        % Debugging: Print s and y
        disp('s (step) vector:');
        disp(s);
        disp('y (gradient difference) vector:');
        disp(y);

        if (s' * y) > 0
            rho = 1 / (y' * s);
            H = (eye(n) - rho * (s * y')) * H * (eye(n) - rho * (y * s')) + rho * (s * s');
        end

        x = x_next;
        iterates = [iterates; x'];
    end

    center = x';  % Return the estimated center as row vector
end
