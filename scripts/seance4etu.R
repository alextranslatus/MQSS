# QUELQUES OPERATIONS DE BASE SUR R ####

# du calcul


# création d'objets quanti et quali


# création de vecteurs = le principe des variables

# il est alors possible d'effectuer des opérations mathématiques sur ces vecteurs et d'en faire une analyse statistique



# CHARGEMENT DE LA BASE ####

library(data.table)
library(readxl)

etupol_1402_net <- read_excel("data/etupol 1402_net.xlsx", 
                              sheet = "etupol")

etupol <- as.data.table(etupol_1402_net)

## DESCRIPTION DE LA BASE ####

# nombre de lignes

# nombre de colonnes

# synthèse des deux infos précédentes

# nom de l'ensemble des variables de la base

## ANALYSE UNIVARIEE ####

# tableau des modalités d'une variable quali ou quanti, ou tri à plat


# qu'est-ce qui cloche ici ? valeurs aberrantes# Toutefois, ils ne sont pas nombreux donc cela ne changera pas grand chose à l'analyse.
# On peut donc les laisser en l'état, ou les recoder, par exemple en non réponse (NA)
# Ici, les modalités "aberrantes" = NA
# On vérifie

# si l'on veut obtenir les fréquences de répartition d'une variable


# La colonne n représente les effectifs de chaque catégorie, la colonne % le pourcentage, et la colonne val% le pourcentage calculé sur les valeurs valides, donc en excluant les NA.
# Une ligne a également été rajoutée pour indiquer le nombre et la proportion de NA.

# moyenne d'une variable


# marche pas : pourquoi ?

# Type de variables : charactère, numérique ou facteur


# Permet d'afficher les premières lignes de la base 


# Permet d'afficher les dernières lignes de la base 

# REPRESENTATIONS GRAPHIQUES ####

# marche pas, pourquoi ?

# on va utiliser un truc plus flexible : ggplot2


# Quelques éléments pour compléter la séance 3 ####

# intervalle de confiance de la moyenne, à 95%
# avec un autre niveau de confiance

# proportion par lesquelles on veut couper la série
# on peut aussi écrire: probs = seq(0, 1, 0.1) séquence de 0 à 1 par tranche de 0.1

# Créer une variable catégorielle ####


# On réordonne pour choisir l'ordre d'apparition dans nos tableaux


# Que faire des "NA" ? Il s'agit de personnes qui n'ont pas répondu à la question.
# La réponse dépend de votre question de recherche et des variables utilisées.


# Création d'une sous-base avec les répondants ayant indiqué le métier de leur mère ####

# on regarde le nombre de NA
# 12593 personnes l'ont indiqué 
# on vérifie que la base contient bien 12593 individus


# Découper une variable numérique en classes ####

# on vérifie que ça a bien marché




###### Exercices #####

# 1. Regarder les effectifs de CAUSES_INSEC et CAUSES_ENVIR en %


# ou avec baseR/sans package nécessaire: 


# 2. Réalisez un histogramme pour la variable ACTUALITES_CLIMAT


# 3. Créez deux bases de données, l'une n'incluant que les femmes, l'autre que les hommes, en utilisant la fonction subset
# la fonction prend la forme subset(base, variable == "Nom")


# 4. Maintenant, réalisez un histogramme de ACTUALITES_CLIMAT pour les femmes, puis pour les hommes


# On voit que l'on commence déjà un petit peu à faire de l'analyse bivariée, whoop whoop!!


# 5. Recoder la variable ACTUALITES_CLIMAT en une variable avec deux niveaux, en 
# regroupant Ne sait pas / non concerné et Je n'ai pas réagi dans un niveau, et
# J'ai partagé, commenté ou réagi dans un autre niveau

# Vous pouvez reprendre les étapes 2 à 4 avec cette variable binaire

    # 2. 
    
    
    # 3. 
    
    # 4. 






