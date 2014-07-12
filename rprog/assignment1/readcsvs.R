readCSVs <- function(directory, ids) {
  dirlen <- nchar(directory)
  if (substr(directory, dirlen, dirlen) != "/") {
    directory <- paste(directory, "/", sep="")
  }
  
  files <- paste(directory, dir(path=directory, pattern="*.csv"), sep="")[ids]
  lapply(files, read.csv)
}
