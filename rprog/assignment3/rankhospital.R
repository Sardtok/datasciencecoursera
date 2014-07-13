make.rankhospital <- function() {
  hospital_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hospital_data <- hospital_data[,c(11,17,23,7,2)]
  hospital_data[,1:3] <- suppressWarnings(sapply(hospital_data[,1:3], as.numeric))
  types <- colnames(hospital_data)[1:3]
  names(types) <- c("heart attack", "heart failure", "pneumonia")
  
  function(state, outcome, num = "best") {
    data <- hospital_data[hospital_data[,4] == state,]
    
    if (dim(data)[1] == 0) {
      stop("invalid state")
    }
    
    if (!match(outcome, names(types), nomatch=FALSE)) {
      stop("invalid outcome")
    }
    
    outcome <- types[outcome]
    
    data <- data[!is.na(data[,outcome]),c(outcome, "Hospital.Name")]
    
    if (num == "best") {
      num = 1
    } else if (num == "worst") {
      num = dim(data)[1]
    } else if (!is.numeric(num)) {
      stop("invalid rank")
    }
    
    if (num < 1 | num > dim(data)[1]) {
      return(NA)
    }
    
    data[order(data[,1], data[,2])[num],2]
  }
}

rankhospital <- make.rankhospital()
