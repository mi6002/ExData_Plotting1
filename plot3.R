##plot3.R - Time Series of Global Active Power by 3 submeters
## Usage: It is assumed that the data.table package has been installed
## The following line is included to ensure that the code is self-contained
library(data.table)

## Read data, convert dates and subset on two days in February 2007
data <- read.table("./household_power_consumption.txt", sep=";", header=T, 
                   colClasses = c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"),
                   na.strings="?")
data$DateTime <- strptime(paste(data$Date, data$Time), 
                          "%d/%m/%Y %H:%M:%S")
data <- subset(data, 
               as.Date(DateTime) >= as.Date("2007-02-01") & 
                 as.Date(DateTime) <= as.Date("2007-02-02"))

##Open PNG device, create plot3.png in working directory, specify height and width dimensions
png("plot3.png", height=480, width=480)

##Create time series for the 3 submeters and send to file
plot(data$DateTime, 
     data$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'))

##Close PNG file device
dev.off()
