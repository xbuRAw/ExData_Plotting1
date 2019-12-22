# load libs and set dir
library("data.table")
# setwd("~/odrive/data/courseraDS")

# read in data using data.table package for better efficiency
powerData <- fread(input = "household_power_consumption.txt", na.strings = "?")

# merging Date/Time to POSIXct format
powerData[, dateCol := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# only use relevant dates between 2007-02-01 and 2007-02-02
powerData <- powerData[(dateCol >= "2007-02-01") & (dateCol < "2007-02-03")]

# open png device
png("plot4.png", width = 480, height = 480)

# allocate subplots
par(mfrow = c(2, 2))

# sub plot 1
plot(powerData[, dateCol], powerData[, Global_active_power], type = "l", xlab = "", ylab = "Global Active Power")

# sub plot 2
plot(powerData[, dateCol], powerData[, Voltage], type = "l", xlab = "datetime", ylab = "Voltage")

# sub plot 3
plot(powerData[, dateCol], powerData[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData[, dateCol], powerData[, Sub_metering_2], col = "red")
lines(powerData[, dateCol], powerData[, Sub_metering_3], col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "),
  lty = c(1, 1), bty = "n", cex = .6)

# sub plot 4
plot(powerData[, dateCol], powerData[, Global_reactive_power], type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# close graphics device
dev.off()