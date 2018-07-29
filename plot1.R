## Format date to Type Date
epc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

epc$Date <- as.Date(t$Date, "%d/%m/%Y")
  
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
epct <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
epct <- epct[complete.cases(epct),]

## Combine Date and Time column
dateTime <- paste(epct$Date, epct$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Remove Date and Time column
epct <- epct[ ,!(names(t) %in% c("Date","Time"))]
   
## Add DateTime column
epct <- cbind(dateTime, epct)
   
## Format dateTime Column
epct$dateTime <- as.POSIXct(dateTime)


png(filename = "plot1.png", width = 480, height=480)
hist(epct2$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()