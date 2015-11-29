#data from http://api.bitcoincharts.com/v1/csv/

library(parallel)
library(microbenchmark)
library(fasttime)
library(dbConnect)

#unzip and load data
setwd("d:/data");
tradesfile = gzfile("bitfinexUSD.csv.gz")
trades = read.csv(tradesfile)

names(trades)[1] = "Timestamp"
names(trades)[2] = "Price"
names(trades)[3] = "Volume"

timestampToFilterBy = as.numeric(as.POSIXct("2015-01-01 0:00:00 EST"))

tradesSmall = subset(trades, Timestamp > timestampToFilterBy)

y = 0
formatTime = function(x, theFormat){
  if(y %% 100000 == 0) {
    print(y);  
  }
  y<<-y+1
  return(format(unix2POSIXct(x, type = "second"), format=theFormat));
}

formatDayOfWeek = function(z) {formatTime(z,"%a")}
formatHourOfDay = function(z) {formatTime(z,"%H")}
formatMinuteOfDay = function(z) {formatTime(z,"%M")}

#day of week, hour of day, mintue of day
tradesSmall$DayOfWeek = unlist(sapply(tradesSmall$Timestamp, formatDayOfWeek))
tradesSmall$HourOfDay = unlist(sapply(tradesSmall$Timestamp, formatHourOfDay))
tradesSmall$MinuteOfDay = unlist(sapply(tradesSmall$Timestamp, formatMinuteOfDay))
