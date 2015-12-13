# read  Electric power consumption data;  dataset missing <- ?
powdata<-read.table("data\\household_power_consumption.txt",
                    header=TRUE,
                    sep=";",
                    na.strings="?")
# Combine date to single timestamp 
powdata$Timestamp <- strptime(paste(powdata$Date,powdata$Time),
                              format="%d/%m/%Y %H:%M:%S")
#subset data between "2007-02-01" & "2007-02-03"
powsubSet =subset(powdata,as.Date(powdata$Timestamp) >= "2007-02-01" 
                  & as.Date(powdata$Timestamp) < "2007-02-03")
powsubSet$Sub_metering_1 <- as.numeric(as.character(powsubSet$Sub_metering_1))
powsubSet$Sub_metering_2 <- as.numeric(as.character(powsubSet$Sub_metering_2))
powsubSet$Sub_metering_3 <- as.numeric(as.character(powsubSet$Sub_metering_3))

plot(powsubSet$Timestamp,powsubSet$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

lines(powsubSet$Timestamp,powsubSet$Sub_metering_2,col="red")
lines(powsubSet$Timestamp,powsubSet$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
cat("plot3.png has been saved in", getwd())
