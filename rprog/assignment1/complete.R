source("readcsvs.R")

complete <- function(directory, id = 1:332) {
  data <- readCSVs(directory, id)
  data <- t(sapply(data,
                   function(x)
                     c(x[1,4], sum(!is.na(x[,"sulfate"])
                                   & !is.na(x[,"nitrate"])))))
  colnames(data) <- c("id", "nobs")
  data.frame(data)
}