source("readcsvs.R")
source("complete.R")

corr <- function(directory, threshold = 0) {
  filter <- complete(directory)
  filter <- filter[filter[,2] > threshold,1]
  data <- readCSVs(directory, filter)
  data <- lapply(data, `[`, TRUE, c(2,3))
  data <- sapply(data, function(x) cor(x[,"sulfate"], x[, "nitrate"], use="complete.obs"))
  data
}