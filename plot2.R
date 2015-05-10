## Plot 2 graphs global active power over time

## Read table from household_power_consumption.txt file in working directory
## Download available from:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
table <- read.table("household_power_consumption.txt",
                    sep = ";",
                    header = TRUE,
                    na.strings = "?",
                    colClasses = c("character", "character", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric"))

## Convert Date column from character to date
table$Date <- as.Date(table$Date, "%d/%m/%Y")

## Convert Time column from character to time and drop date component
table$Time <- strptime(table$Time, "%H:%M:%S")
table$Time <- format(table$Time, "%H:%M:%S")

## Set and apply date filter to table
filter <- as.Date(c("2007-02-02", "2007-02-01"))
table <- table[table$Date %in% filter,]

## Establish x-axis datetime and y-axis global active power components
x <- as.POSIXct(paste(table$Date, table$Time))
y <- table$Global_active_power

## Begin writing to png file
png(file = "plot2.png")
plot(x,
     y,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")
dev.off()