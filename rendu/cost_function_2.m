function cost = cost_function_2(cx, cy, sigma)
    load("measured_points.mat");
    R = 1.5;
    
    cost = sum(log(1+((sqrt((xi - cx).^2 + (yi - cy).^2) - R).^2)/(sigma.^2))/2);
end
