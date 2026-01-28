

library(readxl)
library(data.table)

etupol_1402_net <- read_excel("data/etupol 1402_net.xlsx", 
                              sheet = "etupol")
View(etupol_1402_net)

etupol <- as.data.table(etupol_1402_net)

table(etupol$ECHELLE)

etupol[ECHELLE == "1 Très à gauche", echelle:= 1]
etupol[ECHELLE == "2", echelle:= 2]
etupol[ECHELLE == "3", echelle:= 3]
etupol[ECHELLE == "4", echelle:= 4]
etupol[ECHELLE == "5 Très à droite", echelle:= 5]

table(etupol$echelle, useNA = "always")

hist(etupol$echelle, main = "Sur une échelle de 1 à 5, comment
positionnez-vous vos parents (ou tuteur·rices) sur une
échelle politique (3 étant au centre) ?")

mean(etupol$echelle, na.rm = TRUE)

median(etupol$echelle, na.rm = T)

sd(etupol$echelle, na.rm = TRUE) 

quantile(etupol$echelle, na.rm = TRUE)

