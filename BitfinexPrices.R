library(parallel)

setwd("c:/data");

prices <- read.csv("C:/data/.bitfinexUSD.csv", header=FALSE)

head(prices, 10)

names(prices)[1] = "Timestamp"
names(prices)[2] = "Price"
names(prices)[3] = "Volume"

#create dates
toDateFunction = function(x){as.POSIXct(x, origin="1970-01-01")}
prices$TheDate = mclapply(prices$Timestamp, toDateFunction)

#create day of week
toDayOfWeek = function(x){format(x, format="%a")}
prices$DayOfWeek = mclapply(prices$TheDate, toDayOfWeek)

#create day of week
toHourOrDay = function(x){format(x, format="%H")}
prices$HourOfDay = mclapply(prices$TheDate, toHourOrDay)

class(prices$TheDate)

prices$TheDate[1]

as.POSIXct(1364767668, origin="1970-01-01")

write.csv(prices, "btc-prices-processed.csv")
save(prices, file="bitfinex.Rdata")
