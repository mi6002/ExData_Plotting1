##plot4.R - Multiple plots of time series of global active power, voltage,
##         submetering and global reactive power
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

##Open PNG device, create plot4.png in working directory, specify height and width dimensions
png("plot4.png", height=480, width=480)

##Set up frame for multiple plots
par(mfrow=c(2,2))

##Global Active Power plot
plot(data$DateTime, 
     data$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power") #No kW units to match sample figure
     lines(data$DateTime, data$Global_active_power)

##Voltage plot
plot(data$DateTime, data$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
    lines(data$DateTime, data$Voltage)

##Submetering plot
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
       col = c('black', 'red', 'blue'),
       bty = 'n')

##Global reactive power plot
with(data, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(data, lines(DateTime, Global_reactive_power)) 
#underscores inserted to match sample figure

##Close PNG file device
dev.off()
