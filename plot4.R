plot4 <- function(){
  ##read data
  data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
  
  ##convert first column to dates
  data[,1] <- as.Date(data[,1], format="%d/%m/%Y")
  
  ##subset to dates needed
  data <- data[data$Date == as.Date("2007-02-01")|data$Date == as.Date("2007-02-02"),]
  
  ##bind new column with combined dates and times
  dateTime <- strptime(paste(data[,1], data[,2]), format="%Y-%m-%d %H:%M:%S")
  data <- cbind(dateTime, data)
  
  ##set plot rows
  par(mfcol=c(2,2))
  
  ##create plot 1
  plot(data$dateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  ##create plot 2
  with(data, plot(dateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
  with(data, lines(dateTime, Sub_metering_1, col="black"))
  with(data, lines(dateTime, Sub_metering_2, col="red"))
  with(data, lines(dateTime, Sub_metering_3, col="blue"))
  legend("topright", lty=c(1,1,1), lwd=c(2.5,2.5,2.5), box.lwd=c(0), cex=0.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ##create plot 3
  plot(data$dateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  #create plot 4
  plot(data$dateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  ##save to png file
  dev.copy(png, file = "plot4.png")
  dev.off()
  
}