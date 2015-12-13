#read Electric power consumption data; 
#clean and process data
#create & arrange plots 

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
#prepare data
powsubSet$Sub_metering_1 <- as.numeric(as.character(powsubSet$Sub_metering_1))
powsubSet$Sub_metering_2 <- as.numeric(as.character(powsubSet$Sub_metering_2))
powsubSet$Sub_metering_3 <- as.numeric(as.character(powsubSet$Sub_metering_3))

# draw plots - arrange plots
par(mfrow=c(2,2))

##PLOT 1 - Global_active_powe
plot(powsubSet$Timestamp,powsubSet$Global_active_power, type="l", xlab="", ylab="Global Active Power")
##PLOT 2 - Voltage
plot(powsubSet$Timestamp,powsubSet$Voltage, type="l", xlab="datetime", ylab="Voltage")

##PLOT 3 - Energy sub metering
plot(powsubSet$Timestamp,powsubSet$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(powsubSet$Timestamp,powsubSet$Sub_metering_2,col="red")
lines(powsubSet$Timestamp,powsubSet$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly

#PLOT 4 - Global_reactive_power
plot(powsubSet$Timestamp,powsubSet$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# o/p
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
cat("plot4.png has been saved in", getwd())