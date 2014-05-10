## Script to draw plot 2 from the Course Project 1 
## for the Coursera Class Exploratory Data Analysis
## It assumes that the data file is located in the directory one level up from the script
## location. It loads the required data and draws the plot, saving it as plot2.png


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
png(file="plot2.png")

## draw the plot
with(powerData,plot(datetime,Global_active_power,"l",xlab="",ylab="Global Active Power (kilowatts)",main=""))

## close the device and save the file
dev.off()