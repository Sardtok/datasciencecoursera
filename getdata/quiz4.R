# Code needed for answers to quiz 4 of the getdata course

# Helper function for downloading and reading files
source("download.R")

# Question 1
ss06hid <- downloadAndRead("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ",
                           "ss06hid.csv", nrows=1) # We only need the column names
print("Variable 123 split by wgtp:")
print(strsplit(colnames(ss06hid), "wgtp")[[123]])

# Question 2
GDP <- downloadAndRead("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "GDP.csv",
                       skip=3, nrows=191)[2:191,]
GDP$US.dollars. <- as.numeric(gsub(",", "", GDP$US.dollars.))
print("Mean GDP in millions of dollars:")
print(mean(GDP$US.dollars.))

# Question 3
print("Number of countries starting with United:")
print(sum(grepl("^United", GDP$Economy)))

# Question 4
EDSTATS_Country <- downloadAndRead("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                                   "EDSTATS_Country.csv")
GDP_EDSTATS <- merge(EDSTATS_Country, GDP, by=1, all=FALSE)
print("Countries ending their fiscal year in June:")
print(sum(grepl("Fiscal year end: June", GDP_EDSTATS$Special.Notes)))

# Question 5
if (!("quantmod" %in% installed.packages()[,"Package"])) {
  install.packages("quantmod")
}
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = as.POSIXlt(index(amzn))
print("Values collected in 2012:")
print(sum(sampleTimes$year == 112))
print("Values collected on Mondays in 2012:")
print(sum(sampleTimes$year == 112 & sampleTimes$wday == 1))
