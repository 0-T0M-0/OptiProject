function [gx, gy] = gradient_diff_finie_1(point, delta)
    x = point(1);
    y = point(2);
    
    delta_x = delta(1);
    delta_y = delta(2);
    
    gx = (cost_function(x + delta_x, y) - cost_function(x, y)) / delta_x;
    gy = (cost_function(x, y + delta_y) - cost_function(x, y)) / delta_y; 
end
