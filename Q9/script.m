clc;
close all;
load('measured_points.mat')
%% Q9
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
sigma1 = arrayfun(@cost_function_2, cx, cy, 1e-4);
sigma2 = arrayfun(@cost_function_2, cx, cy, 0.1);
sigma3 = arrayfun(@cost_function_2, cx, cy, 10);

% Visualisation des résultats
figure;
surf(cx, cy, sigma1);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût, sigma=1e-4');

figure;
contour(cx, cy, sigma1);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût, sigma=1e-4');
figure;

surf(cx, cy, sigma2);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût, sigma=0.1');

figure;
contour(cx, cy, sigma2);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût, sigma=0.1');

figure;
surf(cx, cy, sigma3);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût, sigma=10');

figure;
contour(cx, cy, sigma3);
xlabel('cx');
ylabel('cy');
zlabel('Erreur de la fonction de coût');
title('Visualisation de la fonction de coût, sigma=10');

