
##Download the zip file containing the data and unzip the data

if(!file.exists("./Project1")){dir.create("./Project1")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl,destfile = "./Project1/data.zip", method = "auto")

unzip("./Project1/data.zip",exdir = "./Project1")

##Read the data. Specify the ";" seperator and the "?" NA values
powerData <- read.table("./Project1/household_power_consumption.txt",sep = ";", header = TRUE, na.strings = "?")

##Subset the data to only include 2/1/07 and 2/2/07
powerData <- subset(powerData, Date == "1/2/2007" | Date == "2/2/2007")

## Create a new column that is the combined date and time
powerData$DateandTime <- strptime(paste(powerData$Date, powerData$Time,sep = " "),"%d/%m/%Y %H:%M:%S")

## Initialize the Graph and add the line
with(powerData,plot(DateandTime,Global_active_power, type = "n",xlab = "", ylab = "Global Active Power (kilowatts)"))
lines(powerData$DateandTime,powerData$Global_active_power)

## save the plot as a 480X480 png file
dev.copy(png,file = "./Project1/plot2.png", height = 480, width = 480)

dev.off()