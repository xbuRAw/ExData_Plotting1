# load libs and set dir
library("data.table")
# setwd("~/odrive/data/courseraDS")

# read in data using data.table package for better efficiency
powerData <- fread(input = "household_power_consumption.txt", na.strings = "?")

# merging Date/Time to POSIXct format
powerData[, dateCol := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# only use relevant dates between 2007-02-01 and 2007-02-02
powerData <- powerData[(dateCol >= "2007-02-01") & (dateCol < "2007-02-03")]

# open png device, plot lines with successive base lib method, close graphics device
png("plot3.png", width = 500, height = 500)
plot(powerData[, dateCol], powerData[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData[, dateCol], powerData[, Sub_metering_2], col = "red")
lines(powerData[, dateCol], powerData[, Sub_metering_3], col = "blue")
legend("topright", col = c("black", "red", "blue"),
  c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "), lty = c(1, 1), lwd = c(1, 1))
dev.off()