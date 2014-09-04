plot1 <- function(){

##read data
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

##convert first column to dates
data[,1] <- as.Date(data[,1], format="%d/%m/%Y")

##subset to dates needed
data <- data[data$Date == as.Date("2007-02-01")|data$Date == as.Date("2007-02-02"),]

##convert global active power to numeric from factor
data$Global_active_power <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]

##set plot rows
par(mfcol=c(1,1))

##plot histogram
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

##save to png file
dev.copy(png, file = "plot1.png")
dev.off()

}