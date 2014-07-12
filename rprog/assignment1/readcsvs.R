library(data.table)

readCSVs <- function(directory, ids) {
  dirlen <- nchar(directory)
  if (substr(directory, dirlen, dirlen) != "/") {
    directory <- cat(directory, "/", sep="")
  }
  
  files <- paste(directory, dir(directory, "*.csv")[ids], sep="")
  lapply(files, read.csv)
}
