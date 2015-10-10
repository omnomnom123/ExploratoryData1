Energy<-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   col.names = c("Date", "Time", "Global_active_power", 
                                 "Global_reactive_power", "Voltage", "Global_intensity", 
                                 "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

Energy<-within(Energy, DateTime<-as.POSIXct(paste(Date, Time), 
                                            format="%d/%m/%Y %H:%M:%S"))

Energy2<-filter(Energy, DateTime>=as.POSIXct("2007-02-01 00:00:00"), 
                DateTime<as.POSIXct("2007-02-03 00:00:00")) 

Energy2$Global_active_power2=as.numeric(paste(Energy2$Global_active_power))

Energy2$Sub_metering_1b=as.numeric(paste(Energy2$Sub_metering_1))

Energy2$Sub_metering_2b=as.numeric(paste(Energy2$Sub_metering_2))

Energy2$Sub_metering_3b=as.numeric(paste(Energy2$Sub_metering_3))

Energy2$Voltage2=as.numeric(paste(Energy2$Voltage))

Energy2$Global_reactive_power2=as.numeric(paste(Energy2$Global_reactive_power))

dev.new(width=5, height=5)

png('plot4.png')

par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Energy2, {
    plot(Energy2$DateTime, Energy2$Global_active_power2, type="l", xlab="",
         ylab = "Global Active Power")
    
    plot3<-plot(Energy2$DateTime, Energy2$Sub_metering_1b, type = "n", xlab = "", ylab = "Energy sub metering")
    with(plot3, lines(Energy2$DateTime, Energy2$Sub_metering_1b))
    with(plot3, lines(Energy2$DateTime, Energy2$Sub_metering_2b, col="red"))
    with(plot3, lines(Energy2$DateTime, Energy2$Sub_metering_3b, col="blue"))
    legend("topright", col = c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex = 0.8)
    
    plot(Energy2$DateTime, Energy2$Voltage2, type="l", xlab="datetime",
         ylab = "Voltage")
    
    plot(Energy2$DateTime, Energy2$Global_reactive_power2, type="l", xlab="datetime",
         ylab = "Global_reactive_power")
    
})

dev.off()
