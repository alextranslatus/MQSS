# QUELQUES OPERATIONS DE BASE SUR R ####

# du calcul
2+2

# création d'objets quanti et quali
x <- 2+2
y <- 6
x + y

z <- "Chien"
races <- c("Jack", "Labrador", "Teckel")
races

# création de vecteurs = le principe des variables

# il est alors possible d'effectuer des opérations mathématiques sur ces vecteurs et d'en faire une analyse statistique

tailles <- c(156, 202, 150)
tailles / 100
tailles


# CHARGEMENT DE LA BASE ####

library(data.table)
library(readxl)

etupol_1402_net <- read_excel("data/etupol 1402_net.xlsx", 
                              sheet = "etupol")

etupol <- as.data.table(etupol_1402_net)

## DESCRIPTION DE LA BASE ####

# nombre de lignes
nrow(etupol)
# nombre de colonnes
ncol(etupol)
# synthèse des deux infos précédentes
dim(etupol)
# nom de l'ensemble des variables de la base
names(etupol)

## ANALYSE UNIVARIEE ####

# tableau des modalités d'une variable quali ou quanti, ou tri à plat
table(etupol$STATUT_MERE, useNA = "always")
table(etupol$AGE)
# qu'est-ce qui cloche ici ? valeurs aberrantes# Toutefois, ils ne sont pas nombreux donc cela ne changera pas grand chose à l'analyse.
# On peut donc les laisser en l'état, ou les recoder, par exemple en non réponse (NA)

str(etupol$AGE)


etupol$AGE <- as.numeric(etupol$AGE)

str(etupol$AGE)

etupol[AGE > 100 | AGE < 17, AGE:= NA]

  # Ici, les modalités "aberrantes" = NA
table(etupol$AGE, useNA = "always") # On vérifie

# si l'on veut obtenir les fréquences de répartition d'une variable
install.packages("questionr")
library(questionr)

freq(etupol$AGE)
freq(etupol$STATUT_MERE)

round(prop.table(table(etupol$STATUT_MERE))*100, 1)

# La colonne n représente les effectifs de chaque catégorie, la colonne % le pourcentage, et la colonne val% le pourcentage calculé sur les valeurs valides, donc en excluant les NA.
# Une ligne a également été rajoutée pour indiquer le nombre et la proportion de NA.

# moyenne d'une variable
mean(etupol$STATUT_MERE)
# marche pas : pourquoi ?

# Type de variables : charactère, numérique ou facteur
str(etupol$AGE)
str(etupol$STATUT_MERE)

# Permet d'afficher les premières lignes de la base 
head(etupol$STATUT_MERE)

# Permet d'afficher les dernières lignes de la base 
tail(etupol$STATUT_MERE)

# REPRESENTATIONS GRAPHIQUES ####

hist(etupol$AGE)
hist(etupol$STATUT_MERE)
# marche pas, pourquoi ?

# on va utiliser un truc plus flexible : ggplot2
install.packages("ggplot2")
library(ggplot2)

ggplot(etupol, aes(x = STATUT_MERE)) +
  geom_bar(fill = "lightblue") +
  theme_minimal() +
  labs(title = "Statut de la mère",
       x = "",
       y = "Fréqence") +
  coord_flip()

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
ggplot(etupol, aes(x = ACTUALITES_CLIMAT)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction face aux enjeux climatiques") +
  theme_minimal() +
  coord_flip()

# 3. Créez deux bases de données, l'une n'incluant que les femmes, l'autre que les hommes, en utilisant la fonction subset
# la fonction prend la forme subset(base, variable == "Nom")


# 4. Maintenant, réalisez un histogramme de ACTUALITES_CLIMAT pour les femmes, puis pour les hommes


# On voit que l'on commence déjà un petit peu à faire de l'analyse bivariée, whoop whoop!!


# 5. Recoder la variable ACTUALITES_CLIMAT en une variable avec deux niveaux, en 
# regroupant Ne sait pas / non concerné et Je n'ai pas réagi dans un niveau, et
# J'ai partagé, commenté ou réagi dans un autre niveau
table(etupol$ACTUALITES_CLIMAT)
etupol$reaction <- NA
etupol[ACTUALITES_CLIMAT == "J’ai partagé, commenté ou réagi (liké)", reaction:= "J’ai partagé, commenté ou réagi (liké)"]
etupol[ACTUALITES_CLIMAT %in% c("Ne sait pas / non concerné", "Je n’ai pas réagi"), reaction:= "Je n’ai pas réagi"]
table(etupol$reaction)

basef <- subset(etupol, etupol$GENRE == "Une femme")
baseh <- subset(etupol, etupol$GENRE == "Un homme")

dim(basef)
dim(baseh)

ggplot(basef, aes(x = ACTUALITES_CLIMAT)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction des femmes face aux enjeux climatiques") +
  theme_minimal() +
  coord_flip()

ggplot(baseh, aes(x = ACTUALITES_CLIMAT)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction des hommes face aux enjeux climatiques") +
  theme_minimal() +
  coord_flip()


# Vous pouvez reprendre les étapes 2 à 4 avec cette variable binaire

    # 2. 
    
    
    # 3. 
    
    # 4. 






