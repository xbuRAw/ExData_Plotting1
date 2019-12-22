# load libs and set dir
library("data.table")
# setwd("~/odrive/data/courseraDS")

# read in data using data.table package for better efficiency
powerData <- fread(input = "household_power_consumption.txt", na.strings = "?")

# change date column to date type using Subset of Data functionality
powerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# only relevant dates between 2007-02-01 and 2007-02-02
powerData <- powerData[(Date <= "2007-02-02") & (Date >= "2007-02-01")]

# open png device, plot histogram with annotations, close graphics device
png("plot1.png", width = 500, height = 500)
hist(powerData[, Global_active_power], main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()