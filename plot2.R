## plot2.R - Time Series of Global Active Power
## Usage: It is assumed that the data.table package has been installed
## The following line is included to ensure that the code is self-contained
library(data.table)

## Read data, convert dates and subset on two days in February 2007
data <- read.table('./household_power_consumption.txt', sep=';', header=T, 
                   colClasses = c('character', 'character', 'numeric',
                                  'numeric', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric'),
                                  na.strings='?')
data$DateTime <- strptime(paste(data$Date, data$Time), 
                          "%d/%m/%Y %H:%M:%S")
data <- subset(data, 
               as.Date(DateTime) >= as.Date("2007-02-01") & 
                 as.Date(DateTime) <= as.Date("2007-02-02"))

## Open PNG device, create plot2.png in working directory, specify height and width dimensions
png("plot2.png", height=480, width=480)

## Plot time series and send to file
plot(data$DateTime, 
     data$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power)

## Close PNG file device
dev.off()

