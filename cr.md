---
title: Compte-rendu - Projet d’optimisation continue
subtitle: Estimation robuste du centre d’une pièce circulaire
author:
- Justin Bossard
- Tom Mafille
- Ruben Verchere
date: Octobre 2024
documentclass: article
geometry:
- top=2cm
- right=2cm
- bottom=2cm
- left=2cm
papersize: a4
fontsize: 12pt
linkcolor: blue
lang: fr-FR
header-includes:
- \usepackage{calrsfs}
- \DeclareMathAlphabet{\pazocal}{OMS}{zplm}{m}{n}
---

1. On a : $\pazocal{C}_{TLS}(c_{x},c_{y})=\displaystyle \sum _{i=1} ^{n} (D_{i}-R)^{2}$. On obtient les tracés suivants, avec un pas arbitraire de $0,05$ :

   | Sur $[-1,1] \times [-1,2]$          | Sur $[-1,4] \times [-1,4]$          |
   |:-----------------------------------:|:-----------------------------------:|
   | ![](contour_petit.png){width=300px} | ![](contour_grand.png){width=300px} |
   | ![](surf_petit.png){width=300px}    | ![](surf_grand.png){width=300px}    |
   
   Sur la première figure, on a qu'un minimum, tandis que sur la seconde on en observe 2, qu'il faut départager. Il est préférable d'avoir une grande fenêtre, permettant de visualiser tous les minimums potentiels, plutôt qu'une petite fenêtre éliminant des solutions potentielles.
   
2. Pas arbitraire de $10^{-4}$
