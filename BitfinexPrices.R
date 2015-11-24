
library(parallel)
require(parallel)


setwd("c:/data");

trades <- read.csv("C:/data/.bitfinexUSD.csv", header=FALSE)


names(trades)[1] = "Timestamp"
names(trades)[2] = "Price"
names(trades)[3] = "Volume"

#create dates
#toDateFunction = function(x){as.POSIXct(x, origin="1970-01-01")}
#trades$TheDate = mclapply(trades["Timestamp"], FUN=toDateFunction)

#create day of week
toDayOfWeek = function(x){format(as.POSIXct(x, origin="1970-01-01"), format="%a")}
smalltrades$DayOfWeek = lapply(smalltrades["Timestamp"][1], FUN=toDayOfWeek)

#create day of week
toHourOrDay = function(x){strptime(x, format="%H")}
trades$HourOfDay = mclapply(trades["Timestamp"], FUN=toHourOrDay)

class(trades$TheDate)

trades$TheDate[1]

format(as.POSIXct(1364767668, origin="1970-01-01"), format="%a")
as.POSIXct(1364767668, origin="1970-01-01")

write.csv(trades, "btc-trades-processed.csv")
save(trades, file="bitfinex.Rdata")

load("bitfinex.Rdata")


#univariate statistics
daysDistribution = table(trades$DayOfWeek)


tail(trades)

