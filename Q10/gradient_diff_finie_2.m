function [gx, gy] = gradient_diff_finie_2(point, delta)

    x = point(1);
    y = point(2);
    
    delta_x = delta(1);
    delta_y = delta(2);
    sigma = 1;
    
    gx = (cost_function_2(x + delta_x, y, sigma) - cost_function_2(x, y, sigma)) / delta_x;
    gy = (cost_function_2(x, y + delta_y, sigma) - cost_function_2(x, y, sigma)) / delta_y;
    
end
