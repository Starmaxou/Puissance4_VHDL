# Les sources du projet

 - SRC : Regroupement de toutes les sources VHDL du projet
 - Matlab :  Fichier .txt conversion binaire des fichier .png
 - figure_png_jeu :  Fichier .png des figure utilisées
 - src_test_mem : fichier vhdl permettant le test de l'affichage avec la carte Nexys


# Gestion de l'écriture des jetons dans le plateau
| A | B | C | Jeton         |
|:-:|:-:|:-:|:-------------:|
| 0 | 0 | 0 | Blanc         |
| 0 | 0 | 1 | Rouge_Blanc   |
| 0 | 1 | 0 | Rouge_Bleu    |
| 0 | 1 | 1 | Rouge_Vert    |
| 1 | 0 | 0 | Carré_Blanc   |
| 1 | 0 | 1 | Jaune_Blanc   | 
| 1 | 1 | 0 | Jaune_Bleu    |
| 1 | 1 | 1 | Jaune_Vert    |