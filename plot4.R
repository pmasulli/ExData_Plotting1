## Script to draw plot 4 from the Course Project 1 
## for the Coursera Class Exploratory Data Analysis
## It assumes that the data file is located in the directory one level up from the script
## location. It loads the required data and draws the plot, saving it as plot4.png


## Require the package sqldf to efficiently load only the needed rows from the datafile.
## It will fail if the package sqldf is not available
require("sqldf")

## Load only the rows corresponding to the dates we're interested in
query <- "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## data file location
dataFile = "../household_power_consumption.txt"

## read the required rows from the file and set the columns data types
powerData <- read.csv2.sql(dataFile,query,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## convert the Date column to a Date type, reading the format as dd/mm/YYYY
powerData[, "Date"] <- as.Date(powerData[, "Date"], format="%d/%m/%Y")

## Create a new column in the data frame containing the date and time of each observation
powerData[, "datetime"] <- as.POSIXct(paste(powerData$Date,powerData$Time))

## open the graphic device to create the plot png file
png(file="plot4.png")

## draw the plot

## we are going to draw plots in a 2 by 2 matrix, filling it by rows
par(mfrow=c(2,2))

## first plot (similar to plot2)
with(powerData,plot(datetime,Global_active_power,"l",xlab="",ylab="Global Active Power",main=""))

## second plot 
with(powerData,plot(datetime,Voltage,"l",xlab="datetime",ylab="Voltage",main=""))

## third plot (similar to plot3)
with(powerData,plot(datetime,Sub_metering_1,"l",xlab="",ylab="Energy sub metering"))
with(powerData,lines(datetime,Sub_metering_2,"l",col="red"))
with(powerData,lines(datetime,Sub_metering_3,"l",col="blue"))

## bty="n" removes the border around the legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),bty = "n")

## fourth plot
with(powerData,plot(datetime,Global_reactive_power,"l",xlab="datetime",ylab="Global_reactive_power",main=""))

## close the device and save the file
dev.off()