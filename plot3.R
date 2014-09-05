plot3 <- function(){
        
        ##check for file, if it doesn't exist check for the zip, if the zip exists then unzip
        ##if the zip doesn't exist then download and unzip
        if (!file.exists("household_power_consumption.txt")){
                if (file.exists("household_power_consumption.txt.zip")) {    
                        unzip("household_power_consumption.txt.zip")
                }
                else {
                        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.txt.zip", method="curl")
                        unzip("household_power_consumption.txt.zip")
                }
        }
        
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
        par(mfcol=c(1,1))
  
        ##create plot
        with(data, plot(dateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
        with(data, lines(dateTime, Sub_metering_1, col="black"))
        with(data, lines(dateTime, Sub_metering_2, col="red"))
        with(data, lines(dateTime, Sub_metering_3, col="blue"))
        legend("topright", lty=c(1,1,1), lwd=c(2.5,2.5,2.5), cex=1.2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
        ##save to png file
        dev.copy(png, file = "plot3.png")
        dev.off()
  
}