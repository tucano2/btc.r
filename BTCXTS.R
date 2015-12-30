library(xts)
library(quantmod)
library(zoo)

# Code to read compressed .gz files
# http://api.bitcoincharts.com/v1/csv/
# Data Source
bitcoin_file <- "bitfinexUSD.csv.gz"
URL <- "http://api.bitcoincharts.com/v1/csv"
source_file <- file.path(URL,bitcoin_file)
# Data destination on local disk
dataDir <-"c:/DATA"
dest_file <- file.path(dataDir,bitcoin_file)
# Download to disk
download.file(source_file,destfile = dest_file)
# Uncompress .gz file and read into a data frame
raw <- read.csv(gzfile(dest_file),header=FALSE)
head(raw,2)


names(raw) <- c("unixtime","price","amount")

raw$date <- as.POSIXct(raw$unixtime, origin="1970-01-01", tz = "EST")
btcxts = xts(raw$price, raw$date);

##subset data from 2014
btcxts = btcxts["2014/"]

#create multiple time frames (bar sizes)
btcdaily = to.daily(btcxts)
btc10min= to.minutes10(btcxts)
btc3min = to.minutes3(btcxts)
btc1min = to.minutes(btcxts, 1)
btc30secs = to.period(btcxts, period="seconds", 30)
btc5secs = to.period(btcxts, period="seconds", 5)
btc1secs = to.period(btcxts, period="seconds", 1)

#set time period for return calc
bars = btc1secs

periodicity(bars)
#create returns for 3 min bars
bars.Close = bars[,"btcxts.Close"]
head(bars.Close)
returns = diff(log(bars.Close), lag=1)
returns = returns[-1]

summary(data.frame(returns))

plot(returns, main = "rets",
     col = "red", xlab = "Date", ylab = "Return", major.ticks='years',
     minor.ticks=FALSE)


#charting, analyze in more detail
chart_Series(btc3ret["2014-02-10"])
chart_Series(btc3min["2014-02-10"])
btc3min["2014-02-10"]
btcxts["2014-02-10 03:00:00/2014-02-10 06:00:00"]

zoom_Chart("2015-12-25::")



#returns
retDaily = dailyReturn(btcxts)
retAll = allReturns(btcxts)

btcdaily['2015-12']


