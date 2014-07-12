source("readcsvs.R")

pollutantmean <- function(directory, pollutant, id = 1:332) {
  data <- readCSVs(directory, id)
  data <- sapply(data, `[`, TRUE, pollutant)
  data <- sapply(data, function(x) x[!is.na(x)])
  count <- sum(sapply(data, length))
  sum(sapply(data, sum)) / count
}
