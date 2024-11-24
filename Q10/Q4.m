points = [0,0;
          1,1;
          2.5,-0.5;
          3.5, 2;
          0,3];

resultats = zeros(size(points, 2), 4);
delta = [1e-4;1e-4];

for i = 1:size(points, 1)
    x = points(i, 1);  % Coordonnée x du point
    y = points(i, 2);  % Coordonnée y du point
    
    % Appliquer chaque fonction et enregistrer les résultats
    resultats(i, 1) = x;       % Stocker x
    resultats(i, 2) = y;       % Stocker y
    [resultats(i, 3), resultats(i, 5)] = gradientQ10(x, y);
    [resultats(i, 4), resultats(i, 6)] = gradient_diff_finie_2(points(i, :), delta);
    resultats(i, 7) = abs(resultats(i,3)-resultats(i,4)) / abs(resultats(i,3));
    resultats(i, 8) = abs(resultats(i,5)-resultats(i,6)) / abs(resultats(i,5));
end

disp('x         | y       | gx_main | gx_accr | gy_main | gy_accr | err_rel_x | err_rel_y');
disp('-----------------------------------------------------------------------------------');
disp(resultats);
