# load libs and set dir
library("data.table")
# setwd("~/odrive/data/courseraDS")

# read in data using data.table package for better efficiency
powerData <- fread(input = "household_power_consumption.txt", na.strings = "?")

# merging Date/Time to POSIXct format
powerData[, dateCol := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# only relevant dates between 2007-02-01 and 2007-02-02
powerData <- powerData[(dateCol >= "2007-02-01") & (dateCol < "2007-02-03")]

# extract variables to plot
x = powerData[, dateCol]
y = powerData[, Global_active_power]

# open png device, plot line with annotations, close graphics device
png("plot2.png", width = 500, height = 500)
plot(x, y, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()