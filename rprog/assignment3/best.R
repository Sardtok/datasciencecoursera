make.best <- function() {
  hospital_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hospital_data <- hospital_data[,c(11,17,23,7,2)]
  hospital_data[,1:3] <- suppressWarnings(sapply(hospital_data[,1:3], as.numeric))
  types <- colnames(hospital_data)[1:3]
  names(types) <- c("heart attack", "heart failure", "pneumonia")
  
  function(state,outcome) {
    data <- hospital_data[hospital_data[,4] == state,]
    
    if (dim(data)[1] == 0) {
      stop("invalid state")
    }
    
    if (!match(outcome, names(types), nomatch=FALSE)) {
      stop("invalid outcome")
    }
    
    outcome <- types[outcome]
    
    data <- data[!is.na(data[,c[outcome]]),c(outcome, "Hospital.Name")]
    data[order(data[,1], data[,2])[1],2]
  }
}

best <- make.best()
