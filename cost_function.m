function cost = cost_function(cx, cy)
    load("measured_points.mat");
    R = 1.5;
    
    cost = sum((sqrt((xi - cx).^2 + (yi - cy).^2) - R).^2);
end