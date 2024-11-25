function [gx, gy] = gradient_cost(cx, cy)
    load('measured_points.mat');
    R = 1.5;

    n = size(xi, 1);
    gx = 0;
    gy = 0;
    for i = 1:n
        Di = sqrt((xi(i) - cx) .^ 2 + (yi(i) - cy) .^ 2);
        gx = gx + ((cx - xi(i)) * (1 - (R / Di)));
        gy = gy + ((cy - yi(i)) * (1 - (R / Di)));
    end
    gx = 2 * gx;
    gy = 2 * gy;
end