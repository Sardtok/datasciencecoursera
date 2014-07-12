weather <- read.csv(file="hw1_data.csv")

waitForUser <- function() {
  invisible(readline(prompt="..."))
}

# Question 11
print("Column names:")
cat(colnames(weather), sep=", ")
waitForUser()

# Question 12
print("First two rows:")
print(weather[1:2,])
waitForUser()

# Question 13
cat("Number of rows:", nrow(weather))
waitForUser()

# Question 14
print("Last two rows:")
print(weather[(nrow(weather)-1):nrow(weather),])
waitForUser()

# Question 15
cat("Row 47 Ozone:", weather[47,1])
waitForUser()

# Question 16
ozone_na <- is.na(weather[,1])
cat("Missing ozone values: ", sum(ozone_na))
waitForUser()

# Question 17
cat("Mean ozone: ", mean(weather[!ozone_na, 1]))
waitForUser()

# Question 18
high_ozone <- weather[,1] > 31
temp_na    <- is.na(weather[,4])
high_temp  <- weather[,4] > 90
cat("Mean Solar.R for high ozone, high temp weather: ",
    mean(weather[!ozone_na & !temp_na & high_ozone & high_temp, 2]))
waitForUser()

# Question 19
june_rows <- weather[,5] == 6
cat("Mean temperature in June: ",
    mean(weather[june_rows & !temp_na,4]))
waitForUser()

#Question 20
may_rows <- weather[,5] == 5
cat("Max ozone in May: ",
    max(weather[may_rows & !ozone_na,1]))
