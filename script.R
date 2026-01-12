load("IE0243AN_donnees_anonymes.RData")

labels_table <- data.frame(
  variable = names(data),
  label    = sapply(data, function(x) attr(x, "label")),
  stringsAsFactors = FALSE
)

labels_table <- subset(labels_table, !is.na(label))

labels_table



table(data$GROUP1, useNA = "always")
