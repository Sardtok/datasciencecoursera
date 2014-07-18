# Code needed for answers to quiz 3 of the getdata course

# Helper function for downloading and reading files
source("download.R")

# Question 1
ss06hid <- downloadAndRead("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ",
                           "ss06hid.csv")
# ACR - Lot size: 3 = 10+ acres
# AGS - Sales of agricultural products: 6 = $10.000+
agricultureLogical <- {
  acres = ss06hid[,"ACR"]
  sales = ss06hid[,"AGS"]
  !is.na(acres) & !is.na(sales) & acres == 3 & sales == 6
}
print("Indices of first three large lots with large agricultural sales:")
print(which(agricultureLogical)[1:3])

# Question 2
jeff <- downloadAndRead("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "jeff.jpg",
                        native=TRUE)
print(quantile(jeff, c(.3,.8))) # 30th and 80th quantiles

# Question 3
GDP <- downloadAndRead("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "GDP.csv",
                       skip=3, nrows=191) # nrows = 191 to avoid reading non-country information
EDSTATS_Country <- downloadAndRead("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                                   "EDSTATS_Country.csv")
GDP_EDSTATS <- merge(EDSTATS_Country, GDP, by=1, all=FALSE)
GDP_ED_order <- order(GDP_EDSTATS$Ranking, GDP_EDSTATS$CountryCode, decreasing=TRUE)
print("Common countries:")
print(dim(GDP_EDSTATS)[1])
print("13th worst country:")
print(GDP_EDSTATS[GDP_ED_order[12], "Long.Name"])

# Question 4
OECD_HIGH <- GDP_EDSTATS$Income.Group == "High income: OECD"
NON_OECD_HIGH <- GDP_EDSTATS$Income.Group == "High income: nonOECD"
print("OECD:")
print(mean(GDP_EDSTATS[OECD_HIGH, "Ranking"], na.rm=TRUE))
print("Non-OECD:")
print(mean(GDP_EDSTATS[NON_OECD_HIGH, "Ranking"], na.rm=TRUE))

# Question 5
GDP_EDSTATS <- GDP_EDSTATS[!is.na(GDP_EDSTATS$Ranking),]
print(table(GDP_EDSTATS$Income.Group,
            cut(GDP_EDSTATS$Ranking, quantile(GDP_EDSTATS$Ranking, seq(0,1,0.2), na.rm=TRUE),
                include.lowest=TRUE)))
