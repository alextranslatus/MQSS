# QUELQUES OPERATIONS DE BASE SUR R ####

# du calcul
2 + 2
5 - 7
4 * 12
5^2

# création d'objets quanti et quali
x <- 2
y <- 5
resultat <- x + y
resultat

chien <- "Chihuahua"
chien

# création de vecteurs = le principe des variables
tailles <- c(156, 164, 197, 147, 173)
tailles

# il est alors possible d'effectuer des opérations mathématiques sur ces vecteurs et d'en faire une analyse statistique
tailles_m <- tailles / 100
tailles_m

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
table(etupol$AGE, useNA = "always")
# qu'est-ce qui cloche ici ? valeurs aberrantes# Toutefois, ils ne sont pas nombreux donc cela ne changera pas grand chose à l'analyse.
# On peut donc les laisser en l'état, ou les recoder, par exemple en non réponse (NA)
etupol[AGE < 17 | AGE > 80, AGE:= NA] # Ici, les modalités "aberrantes" = NA
table(etupol$AGE, useNA = "always") # On vérifie

# si l'on veut obtenir les fréquences de répartition d'une variable

library(questionr)

freq(etupol$STATUT_MERE)
# La colonne n représente les effectifs de chaque catégorie, la colonne % le pourcentage, et la colonne val% le pourcentage calculé sur les valeurs valides, donc en excluant les NA.
# Une ligne a également été rajoutée pour indiquer le nombre et la proportion de NA.

# moyenne d'une variable
mean(etupol$STATUT_MERE)
# marche pas : pourquoi ?

# Type de variables : charactère, numérique ou facteur
str(etupol$STATUT_MERE) 

# Permet d'afficher les premières lignes de la base 
head(etupol$STATUT_MERE) 

# Permet d'afficher les dernières lignes de la base 
tail(etupol$STATUT_MERE) 

# REPRESENTATIONS GRAPHIQUES ####

hist(etupol$STATUT_MERE)
# marche pas, pourquoi ?

# on va utiliser un truc plus flexible : ggplot2

library(ggplot2)

ggplot(etupol, aes(x = STATUT_MERE)) +
  geom_bar(fill = "darkred") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Statut de la mère des étudiants",
       caption = "Source : Enquête POF - Engagements, politisation et réseaux sociaux (2024-2025) 
       Note : Auteur, gestion des valeurs manquantes...") + 
  ## Il est toujours important de spécifier la source, et en note
  theme_bw() +
  coord_flip()

# Quelques éléments pour compléter la séance 3 ####

etupol$AGE <- as.numeric(etupol$AGE)
min(etupol$AGE, na.rm = TRUE)
max(etupol$AGE, na.rm = TRUE)
mean(etupol$AGE, na.rm = TRUE)
t.test(etupol$AGE) # intervalle de confiance de la moyenne, à 95%
t.test(etupol$AGE, conf.level = 0.9) # avec un autre niveau de confiance
quantile(etupol$AGE, probs = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0), na.rm=TRUE)
         # proportion par lesquelles on veut couper la série
         # on peut aussi écrire: probs = seq(0, 1, 0.1) séquence de 0 à 1 par tranche de 0.1

# Créer une variable catégorielle ####

table(etupol$GENRE)
etupol[GENRE %in% c("Non-binaire ou autre", "Préfère ne pas répondre"), genre:= "Autres"]
etupol[GENRE %in% c("Un homme"), genre:= "Hommes"]
etupol[GENRE %in% c("Une femme"), genre:= "Femmes"]
table(etupol$genre)

# On réordonne pour choisir l'ordre d'apparition dans nos tableaux
etupol$genre <- factor(
  etupol$genre,
  levels = c("Femmes", "Hommes", "Autres")
)

table(etupol$genre, useNA = "always")

# Que faire des "NA" ? Il s'agit de personnes qui n'ont pas répondu à la question.
# La réponse dépend de votre question de recherche et des variables utilisées.


# Création d'une sous-base avec les répondants ayant indiqué le métier de leur mère ####

table(etupol$TYPEPROF_MERE, useNA = "always") # on regarde le nombre de NA
sum(table(etupol$TYPEPROF_MERE)) # 12593 personnes l'ont indiqué 
basemere <- subset(etupol, is.na(etupol$TYPEPROF_MERE) == FALSE)
# on vérifie que la base contient bien 12593 individus

# Découper une variable numérique en classes ####

table(etupol$AGE)
etupol$agecl <- cut(etupol$AGE, c(17, 20, 22, 24, 28, 79), include.lowest = TRUE, 
               labels = c("<= 20ans", "21-22 ans", "23-25 ans", "26-28 ans", "> 28ans"))
table(etupol$agecl, etupol$AGE) # on vérifie que ça a bien marché
table(etupol$agecl)



###### Exercices #####

# 1. Regarder les effectifs de CAUSES_INSEC et CAUSES_ENVIR en %
freq(etupol$CAUSES_INSEC)
freq(etupol$CAUSES_ENVIR)

# ou avec baseR/sans package nécessaire: 
round(prop.table(table(etupol$CAUSES_INSEC))*100, 1)
round(prop.table(table(etupol$CAUSES_ENVIR))*100, 1)

# 2. Réalisez un histogramme pour la variable ACTUALITES_CLIMAT
ggplot(etupol, aes(x = ACTUALITES_CLIMAT)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction face aux enjeux climatiques",
       caption = "Source : Enquête POF - Engagements, politisation et réseaux sociaux (2024-2025) 
       Note : (Auteur, gestion des valeurs manquantes...)") +
  theme_bw() +
  coord_flip()

# 3. Créez deux bases de données, l'une n'incluant que les femmes, l'autre que les hommes, en utilisant la fonction subset
# la fonction prend la forme subset(base, variable == "Nom")
dfem <- subset(etupol, etupol$genre == "Femmes")
dhom <- subset(etupol, etupol$genre == "Hommes")

# 4. Maintenant, réalisez un histogramme de ACTUALITES_CLIMAT pour les femmes, puis pour les hommes
ggplot(dfem, aes(x = ACTUALITES_CLIMAT)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction des femmes face aux enjeux climatiques",
       caption = "Source : Enquête POF - Engagements, politisation et réseaux sociaux (2024-2025) 
       Note : (Auteur, gestion des valeurs manquantes...)") + 
  theme_bw() +
  coord_flip()

ggplot(dhom, aes(x = ACTUALITES_CLIMAT)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction des hommes face aux enjeux climatiques",
       caption = "Source : Enquête POF - Engagements, politisation et réseaux sociaux (2024-2025) 
       Note : (Auteur, gestion des valeurs manquantes...)") + 
  theme_bw() +
  coord_flip()

# On voit que l'on commence déjà un petit peu à faire de l'analyse bivariée, whoop whoop!!


# 5. Recoder la variable ACTUALITES_CLIMAT en une variable avec deux niveaux, en 
# regroupant Ne sait pas / non concerné et Je n'ai pas réagi dans un niveau, et
# J'ai partagé, commenté ou réagi dans un autre niveau

table(etupol$ACTUALITES_CLIMAT)
etupol[ACTUALITES_CLIMAT %in% c("Je n’ai pas réagi", "Ne sait pas / non concerné"), reaction:= "Non-réaction"]
etupol[ACTUALITES_CLIMAT == "J’ai partagé, commenté ou réagi (liké)", reaction:= "Réaction"]
table(etupol$reaction)

# Vous pouvez reprendre les étapes 2 à 4 avec cette variable binaire

# 2. 
ggplot(etupol, aes(x = reaction)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction face aux enjeux climatiques",
       caption = "Source : Enquête POF - Engagements, politisation et réseaux sociaux (2024-2025) 
       Note : (Auteur, gestion des valeurs manquantes...)") + 
  theme_bw() +
  coord_flip()

# 3. 
dfem <- subset(etupol, etupol$genre == "Femmes")
dhom <- subset(etupol, etupol$genre == "Hommes")

# 4. 
ggplot(dfem, aes(x = reaction)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction des femmes face aux enjeux climatiques",
       caption = "Source : Enquête POF - Engagements, politisation et réseaux sociaux (2024-2025) 
       Note : (Auteur, gestion des valeurs manquantes...)") + 
  theme_bw() +
  coord_flip()

ggplot(dhom, aes(x = reaction)) +
  geom_bar(fill = "lightblue") +
  labs(x = "", 
       y = "Fréquence", 
       title = "Réaction des hommes face aux enjeux climatiques",
       caption = "Source : Enquête POF - Engagements, politisation et réseaux sociaux (2024-2025) 
       Note : (Auteur, gestion des valeurs manquantes...)") + 
  theme_bw() +
  coord_flip()







