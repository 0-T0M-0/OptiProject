clc;
clear;
close all;
load('measured_points.mat')

%%
%% Q1
%%

%% 1er intervalle
R = 1.5; % Rayon du cercle

% Intervalle x
xmin = -1;
xmax = 1;

% Intervalle y
ymin = -1;
ymax = 2;

% Pas d'échantillonage
pas = 0.05;

% Création de la grille de points pour cx et cy
[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);

% Calcul de la fonction de coût pour chaque point de la grille
o = arrayfun(@cost_function, cx, cy);

% Visualisation du résultat
figure;
surf(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût');

figure;
contour(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût');


%% 2ème intervalle
close all;

R = 1.5; % Rayon du cercle

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas d'échantillonage
pas = 0.05;

% Création de la grille de points pour cx et cy
[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);

% Calcul de la fonction de coût pour chaque point de la grille
o = arrayfun(@cost_function, cx, cy);

% Visualisation du résultat
figure;
surf(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût');

figure;
contour(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût');

%%
%% Q2
%%

pas=2e-4; %% 2 fois la précision
%% 1er intervalle
% Échantillonnage régulier pour cx et cy dans le premier domaine
cx_range1 = -1:pas:1;
cy_range1 = -1:pas:2;

% Initialiser la fonction de coût minimale
min_cost = inf;
best_cx = 0;
best_cy = 0;

% Boucle d'échantillonnage régulier sur le premier domaine
for cx = cx_range1
    for cy = cy_range1
        cost = cost_function(cx, cy);
        if cost < min_cost
            min_cost = cost;
            best_cx = cx;
            best_cy = cy;
        end
    end
end

% Affichage du résultat
figure;
scatter(xi, yi, 'filled');  % Nuage de points mesurés
hold on;
scatter(best_cx, best_cy, 'filled', 'x', 'MarkerEdgeColor', 'r');
viscircles([best_cx, best_cy], R, 'EdgeColor', 'r');
axis equal;
title('Solution approximée dans le premier domaine');
xlabel('x');
ylabel('y');


%% 2ème intervalle
% Échantillonnage régulier pour cx et cy dans le deuxième domaine
cx_range2 = -1:pas:4;
cy_range2 = -1:pas:4;

% Initialiser la fonction de coût minimale
min_cost = inf;
best_cx = 0;
best_cy = 0;

% Boucle d'échantillonnage régulier sur le deuxième domaine
for cx = cx_range2
    for cy = cy_range2
        cost = cost_function(cx, cy);
        if cost < min_cost
            min_cost = cost;
            best_cx = cx;
            best_cy = cy;
        end
    end
end

% Affichage du résultat
figure;
scatter(xi, yi, 'filled');  % Nuage de points mesurés
hold on;
scatter(best_cx, best_cy, 'filled', 'x', 'MarkerEdgeColor', 'r');
viscircles([best_cx, best_cy], R, 'EdgeColor', 'r');
axis equal;
title('Solution approximée dans le deuxième domaine');
xlabel('x');
ylabel('y');

%%
%% Q4
%%

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
    [resultats(i, 3), resultats(i, 5)] = gradient_cost(x, y);
    [resultats(i, 4), resultats(i, 6)] = gradient_diff_finie_1(points(i, :), delta);
    resultats(i, 7) = abs(resultats(i,3)-resultats(i,4)) / abs(resultats(i,3));
    resultats(i, 8) = abs(resultats(i,5)-resultats(i,6)) / abs(resultats(i,5));
end

disp('x         | y       | gx_main | gx_accr | gy_main | gy_accr | err_rel_x | err_rel_y');
disp('-----------------------------------------------------------------------------------');
disp(resultats);

%%
%% Q5
%%

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas
pas = 0.25;

[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);
[gx gy] = arrayfun(@gradient_cost, cx, cy);

figure;
quiver(cx, cy, gx, gy);
title('Champ de vecteurs des gradients');
xlabel('cx');
ylabel('cy');
axis equal;

o = arrayfun(@cost_function, cx, cy);

hold on;
contour(cx, cy, o, 40);

%%
%% Q6
%%

iterates = steepest_descent_fletcher_lemarechal(0, 0, 15, 1);

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas
pas = 0.25;

[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);
[gx gy] = arrayfun(@gradient_cost, cx, cy);

figure;
quiver(cx, cy, gx, gy);
title('Champ de vecteurs des gradients');
xlabel('cx');
ylabel('cy');
axis equal;

o = arrayfun(@cost_function, cx, cy);

hold on;
contour(cx, cy, o, 40);

hold on;
plot(iterates(:, 1), iterates(:, 2), '-o');
title('Suite des itérés dans le plan (cx, cy)');
xlabel('cx'); ylabel('cy');

%%
%% Q7
%%

iterates = steepest_descent_fletcher_lemarechal(3, -1, 15, 1);

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas
pas = 0.25;

[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);
[gx gy] = arrayfun(@gradient_cost, cx, cy);

figure;
quiver(cx, cy, gx, gy);
title('Champ de vecteurs des gradients');
xlabel('cx');
ylabel('cy');
axis equal;

o = arrayfun(@cost_function, cx, cy);

hold on;
contour(cx, cy, o, 40);

hold on;
plot(iterates(:, 1), iterates(:, 2), '-o');
title('Suite des itérés dans le plan (cx, cy)');
xlabel('cx'); ylabel('cy');

%%
%% Q8
%%

x0 = [0 3];
maxIter = 15;
[center, iterates, cost_values, grad_norms, dist_iter] = quasiNewtonBFGS(@cost_function, @gradient_cost, x0, maxIter);

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas
pas = 0.25;

[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);
[gx gy] = arrayfun(@gradient_cost, cx, cy);

figure;
quiver(cx, cy, gx, gy);
title('Champ de vecteurs des gradients');
xlabel('cx');
ylabel('cy');
axis equal;

o = arrayfun(@cost_function, cx, cy);

hold on;
contour(cx, cy, o, 40);

hold on;
plot(iterates(:, 1), iterates(:, 2), '-o');
title('Suite des itérés dans le plan (cx, cy)');
xlabel('cx'); ylabel('cy');

hold off;
    
% Affichage des résultats
figure;
subplot(2, 2, 1);
plot(iterates(:, 1), iterates(:, 2), '-o');
title('Suite des itérés dans le plan (cx, cy)');
xlabel('cx'); ylabel('cy');

subplot(2, 2, 2);
plot(1:length(cost_values), cost_values);
title('Évolution de la fonction de coût');
xlabel('Itération'); ylabel('Coût'); 

subplot(2, 2, 3);
plot(1:length(grad_norms), grad_norms);
title('Évolution de la norme du gradient');
xlabel('Itération'); ylabel('Norme du gradient');
    
subplot(2, 2, 4);
plot(1:length(dist_iter), dist_iter);
title('Distance entre deux itérés successifs');
xlabel('Itération'); ylabel('Distance');

%%
%% Q9
%%
clear;
clc;
close all;
load('measured_points.mat')
R=1.5;

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

%% sigma = 10e-3

% Pas d'échantillonage
pas = 0.05;

% Création de la grille de points pour cx, cy et sigma
[cx, cy, sigma] = meshgrid(xmin:pas:xmax, ymin:pas:ymax, 10e-3);

% Calcul de la fonction de coût pour chaque point de la grille
o = arrayfun(@cost_function_2, cx, cy, sigma);

% Visualisation du résultat
figure;
surf(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=10e-3');

figure;
contour(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=10e-3');

% Cercle du minimum approché de la solution
pas=0.01;
% Échantillonnage régulier pour cx et cy dans le premier domaine
cx_range1 = xmin:pas:xmax;
cy_range1 = ymin:pas:ymax;

% Initialiser la fonction de coût minimale
min_cost = inf;
best_cx = 0;
best_cy = 0;

% Boucle d'échantillonnage régulier sur le premier domaine
for cx = cx_range1
    for cy = cy_range1
        cost = cost_function_2(cx, cy, 10e-3);
        if cost < min_cost
            min_cost = cost;
            best_cx = cx;
            best_cy = cy;
        end
    end
    cx
end

% Affichage du résultat
figure;
scatter(xi, yi, 'filled');  % Nuage de points mesurés
hold on;
scatter(best_cx, best_cy, 'filled', 'x', 'MarkerEdgeColor', 'r');
viscircles([best_cx, best_cy], R, 'EdgeColor', 'r');
axis equal;
title('Solution approximée pour \sigma=10e-3');
xlabel('x');
ylabel('y');

%% sigma = 0.1
pas = 0.05;
% Création de la grille de points pour cx, cy et sigma
[cx, cy, sigma] = meshgrid(xmin:pas:xmax, ymin:pas:ymax, 0.1);

% Calcul de la fonction de coût pour chaque point de la grille
o = arrayfun(@cost_function_2, cx, cy, sigma);
disp('array fun done')
% Visualisation du résultat
figure;
surf(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=0.1');

figure;
contour(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=0.1');

% Cercle du minimum approché de la solution
pas=0.01;
% Échantillonnage régulier pour cx et cy dans le premier domaine
cx_range1 = xmin:pas:xmax;
cy_range1 = ymin:pas:ymax;

% Initialiser la fonction de coût minimale
min_cost = inf;
best_cx = 0;
best_cy = 0;

% Boucle d'échantillonnage régulier sur le premier domaine
for cx = cx_range1
    for cy = cy_range1
        cost = cost_function_2(cx, cy, 0.1);
        if cost < min_cost
            min_cost = cost;
            best_cx = cx;
            best_cy = cy;
        end
    end
    cx
end

% Affichage du résultat
figure;
scatter(xi, yi, 'filled');  % Nuage de points mesurés
hold on;
scatter(best_cx, best_cy, 'filled', 'x', 'MarkerEdgeColor', 'r');
viscircles([best_cx, best_cy], R, 'EdgeColor', 'r');
axis equal;
title('Solution approximée pour \sigma=0.1');
xlabel('x');
ylabel('y');

%% sigma = 1
pas = 0.05;
% Création de la grille de points pour cx, cy et sigma
[cx, cy, sigma] = meshgrid(xmin:pas:xmax, ymin:pas:ymax, 1);

% Calcul de la fonction de coût pour chaque point de la grille
o = arrayfun(@cost_function_2, cx, cy, sigma);

% Visualisation du résultat
figure;
surf(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=1');

figure;
contour(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=1');

figure;
scatter(xi, yi, 'filled');  % Nuage de points mesurés
hold on;
scatter(best_cx, best_cy, 'filled', 'x', 'MarkerEdgeColor', 'r');
viscircles([best_cx, best_cy], R, 'EdgeColor', 'r');
axis equal;
title('Solution approximée pour \sigma=1');
xlabel('x');
ylabel('y');

%% sigma = 10

pas = 0.05;

% Création de la grille de points pour cx, cy et sigma
[cx, cy, sigma] = meshgrid(xmin:pas:xmax, ymin:pas:ymax, 10);

% Calcul de la fonction de coût pour chaque point de la grille
o = arrayfun(@cost_function_2, cx, cy, sigma);

% Visualisation du résultat
figure;
surf(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=10');

figure;
contour(cx, cy, o);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la seconde fonction de coût, \sigma=10');

% Cercle du minimum approché de la solution
pas=0.01;
% Échantillonnage régulier pour cx et cy dans le premier domaine
cx_range1 = xmin:pas:xmax;
cy_range1 = ymin:pas:ymax;

% Initialiser la fonction de coût minimale
min_cost = inf;
best_cx = 0;
best_cy = 0;
% Boucle d'échantillonnage régulier sur le premier domaine
for cx = cx_range1
    for cy = cy_range1
        cost = cost_function_2(cx, cy, 10);
        if cost < min_cost
            min_cost = cost;
            best_cx = cx;
            best_cy = cy;
        end
    end
    cx
end

% Affichage du résultat
figure;
scatter(xi, yi, 'filled');  % Nuage de points mesurés
hold on;
scatter(best_cx, best_cy, 'filled', 'x', 'MarkerEdgeColor', 'r');
viscircles([best_cx, best_cy], R, 'EdgeColor', 'r');
axis equal;
title('Solution approximée pour \sigma=10');
xlabel('x');
ylabel('y');

%%
%% Q10
%%

load('measured_points.mat')

sigma = 1;

%%
%% Q2
%%

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
    [resultats(i, 3), resultats(i, 5)] = gradient_cost_2(x, y);
    [resultats(i, 4), resultats(i, 6)] = gradient_diff_finie_2(points(i, :), delta);
    resultats(i, 7) = abs(resultats(i,3)-resultats(i,4)) / abs(resultats(i,3));
    resultats(i, 8) = abs(resultats(i,5)-resultats(i,6)) / abs(resultats(i,5));
end

disp('x         | y       | gx_main | gx_accr | gy_main | gy_accr | err_rel_x | err_rel_y');
disp('-----------------------------------------------------------------------------------');
disp(resultats);

%%
%% Q3
%%

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas
pas = 0.25;

[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);
sigmaMatrix(1:size(cx, 1), 1:size(cx, 2)) = sigma;

[gx gy] = arrayfun(@gradient_cost_2, cx, cy, sigmaMatrix);

figure;
quiver(cx, cy, gx, gy);

title('Champ de vecteurs des gradients');
xlabel('cx');
ylabel('cy');
axis equal;

o = arrayfun(@cost_function_2, cx, cy, sigmaMatrix);

hold on;
contour(cx, cy, o, 40);

%%
%% Q5
%%

iterates = steepest_descent_fletcher_lemarechal(0, 0, 15, 1);

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas
pas = 0.25;

[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);
sigmaMatrix(1:size(cx, 1), 1:size(cx, 2)) = sigma;
[gx gy] = arrayfun(@gradient_cost_2, cx, cy, sigmaMatrix);

figure;
quiver(cx, cy, gx, gy);
title('Champ de vecteurs des gradients');
xlabel('cx');
ylabel('cy');
axis equal;

o = arrayfun(@cost_function_2, cx, cy, sigmaMatrix);

hold on;
contour(cx, cy, o, 40);

hold on;
plot(iterates(:, 1), iterates(:, 2), '-o');
title('Suite des itérés dans le plan (cx, cy)');
xlabel('cx'); ylabel('cy');

%%
%% Q6
%%

iterates = steepest_descent_fletcher_lemarechal(3, -1, 15, 1);

% Intervalle x
xmin = -1;
xmax = 4;

% Intervalle y
ymin = -1;
ymax = 4;

% Pas
pas = 0.25;

[cx, cy] = meshgrid(xmin:pas:xmax, ymin:pas:ymax);
sigmaMatrix(1:size(cx, 1), 1:size(cx, 2)) = sigma;
[gx gy] = arrayfun(@gradient_cost_2, cx, cy, sigmaMatrix);

figure;
quiver(cx, cy, gx, gy);
title('Champ de vecteurs des gradients');
xlabel('cx');
ylabel('cy');
axis equal;

o = arrayfun(@cost_function_2, cx, cy, sigmaMatrix);

hold on;
contour(cx, cy, o, 40);

hold on;
plot(iterates(:, 1), iterates(:, 2), '-o');
title('Suite des itérés dans le plan (cx, cy)');
xlabel('cx'); ylabel('cy');
