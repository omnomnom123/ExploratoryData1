Energy<-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   col.names = c("Date", "Time", "Global_active_power", 
                                 "Global_reactive_power", "Voltage", "Global_intensity", 
                                 "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

Energy<-within(Energy, DateTime<-as.POSIXct(paste(Date, Time), 
                                            format="%d/%m/%Y %H:%M:%S"))

Energy2<-filter(Energy, DateTime>=as.POSIXct("2007-02-01 00:00:00"), 
                DateTime<as.POSIXct("2007-02-03 00:00:00")) 

Energy2$Sub_metering_1b=as.numeric(paste(Energy2$Sub_metering_1))

Energy2$Sub_metering_2b=as.numeric(paste(Energy2$Sub_metering_2))

Energy2$Sub_metering_3b=as.numeric(paste(Energy2$Sub_metering_3))

dev.new(width=5, height=5)

png('plot3.png')

plot3<-plot(Energy2$DateTime, Energy2$Sub_metering_1b, type = "n", xlab = "", ylab = "Energy sub metering")

with(plot3, lines(Energy2$DateTime, Energy2$Sub_metering_1b))

with(plot3, lines(Energy2$DateTime, Energy2$Sub_metering_2b, col="red"))

with(plot3, lines(Energy2$DateTime, Energy2$Sub_metering_3b, col="blue"))

legend("topright", col = c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex = 0.8)

dev.off()