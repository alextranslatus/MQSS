
install.packages("data.table")
install.packages("readxl")

library(data.table)
library(readxl)

etupol_1402_net <- read_excel("data/etupol 1402_net.xlsx", 
                              sheet = "etupol")
View(etupol_1402_net)

etupol <- as.data.table(etupol_1402_net)

table(etupol$ECHELLE)

etupol[ECHELLE == "1 Très à gauche", newvar:= 1]
etupol[ECHELLE == "2", newvar:= 2]
etupol[ECHELLE == "3", newvar:= 3]
etupol[ECHELLE == "4", newvar:= 4]
etupol[ECHELLE == "5 Très à droite", newvar:= 5]

table(etupol$newvar)

mean(etupol$newvar, na.rm =T)

hist(etupol$newvar, 
     main = "Comment vous situez-vous sur l’échelle politique ?",
     xlab = "1 = Très à gauche, 5 Très à droite",
     ylab = "Fréquence")

median(etupol$newvar, na.rm =T)

sd(etupol$newvar, na.rm =T)

quantile(etupol$newvar, na.rm = T)
