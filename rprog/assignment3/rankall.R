make.rankall <- function() {
  hospital_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hospital_data <- hospital_data[,c(11,17,23,7,2)]
  hospital_data[,1:3] <- suppressWarnings(sapply(hospital_data[,1:3], as.numeric))
  types <- colnames(hospital_data)[1:3]
  names(types) <- c("heart attack", "heart failure", "pneumonia")
  
  function(outcome, num = "best") {
    if (!match(outcome, names(types), nomatch=FALSE)) {
      stop("invalid outcome")
    }
    
    outcome <- types[outcome]
    data <- hospital_data[!is.na(hospital_data[,outcome]),c(outcome, "Hospital.Name", "State")]
    
    if (num == "best") {
      num = 1
    } else if (num != "worst" & !is.numeric(num)) {
      stop("invalid rank")
    }
    
    data <- split(data, data$State)
    data <- lapply(data, function(x) x[order(x[,1], x[,2]),])
    data <- t(sapply(data,
                     function(x) {
                       if (num == "worst") {
                         c("hospital"=x[[dim(x)[1],2]], "state"=x[[dim(x)[1],3]])
                       } else if (num < 1 | num > dim(x)[1]) {
                         c("hospital"=x[[dim(x)[1],2]], "state"=x[[1,3]])
                       } else {
                         c("hospital"=x[[num,2]], "state"=x[[num,3]])
                       }
                     }))
    data.frame(data)
  }
}

rankall <- make.rankall()
