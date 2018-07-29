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



dev.copy(png, file="plot4.png", height=480, width=480)


par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(epct, {
    plot(Global_active_power~dateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~dateTime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~dateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~dateTime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
  })

dev.off()