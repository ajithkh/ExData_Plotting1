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
powsubSet$Global_active_power <- as.numeric(as.character(powsubSet$Global_active_power))
plot(powsubSet$Timestamp,powsubSet$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480,bg="transparent")
dev.off()
cat("plot2.png has been saved in", getwd())