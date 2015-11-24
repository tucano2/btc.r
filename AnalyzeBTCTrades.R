library(parallel)

setwd("c:/data");
load("bitfinex.Rdata")

mediumSet = tail(prices, 50000)


#table(prices$DayOfWeek)

class(mediumSet)


table(mediumSet$DayOfWeek)

class(smallSet$Timestamp)
