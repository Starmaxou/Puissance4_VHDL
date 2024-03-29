# Description de la machine à état
## Règle du jeu
- Au début du jeu le plateau est vide,
- jaune choisit une colonne où placer le jeton. Le jeton est placer au plus bas dans la colonne selectionnée,
- Rouge joue de la même manière que jaune.
---
Les joueurs jouent à tour de rôle tant que :
- Pas de cas de victoire
- Tant que le plateau n'est pas remplie 
    - 42 jetons au total soit 21 par joueur
---
La victoire est obtenue lorsqu'un joueur aligne 4 jetons de sa couleur.
L'alignement peut être horizontale, verticale, diagonale.

## Description des états
### Initialisation
- La mémoire de plateau est vide

    **L'appui sur le bouton central démarre la partie**


### Jaune joue
- Affichage du jeton jaune en haut du plateau

- L'appui sur le bouton gauche
    - Déplace le jeton sur la gauche du plateau

- L'appui sur le bouton droit
    - Déplace le jeton sur la droite du plateau

- L'appui sur le bouton centrale
    - Valide la position du jeton
    - **Vers test de la victoire**

### Rouge joue
- Affichage du jeton jaune en haut du plateau

- L'appui sur le bouton gauche
    - Déplace le jeton sur la gauche du plateau

- L'appui sur le bouton droit
    - Déplace le jeton sur la droite du plateau

- L'appui sur le bouton centrale
    - Valide la position du jeton
    - **Vers test de la victoire**

### Test de la victoire
- Vérification de la proximité de 4 couleurs identiques
- Si non victoire
    - **Vers Rouge joue** ou **Vers jaune joue**

- Si victoire
    - **Vers victoire**

### Victoire
- L'alignement gagnant est mis en évidence.

    **L'appui sur le bouton central réinistialise le jeu**