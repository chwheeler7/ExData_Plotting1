## Plot 3 graphs energy sub metering over time

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

## Establish x-axis datetime component
x <- as.POSIXct(paste(table$Date, table$Time))

## Begin writing to png file
png(file = "plot3.png")
## Generate plot
plot(x,
     table$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")

## Add data points
  points(x,
         table$Sub_metering_1,
         type = "l")
  points(x,
         table$Sub_metering_2,
         type = "l",
         col = "red")
  points(x,
         table$Sub_metering_3,
         type = "l",
         col = "blue")

## Add legend
  legend("topright",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         pch = "_",
         col = c("black", "red", "blue"))
dev.off()