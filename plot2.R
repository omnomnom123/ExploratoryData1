Energy<-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
    col.names = c("Date", "Time", "Global_active_power", 
    "Global_reactive_power", "Voltage", "Global_intensity", 
    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

Energy<-within(Energy, DateTime<-as.POSIXct(paste(Date, Time), 
                                            format="%d/%m/%Y %H:%M:%S"))

Energy2<-filter(Energy, DateTime>=as.POSIXct("2007-02-01 00:00:00"), 
    DateTime<as.POSIXct("2007-02-03 00:00:00")) 

Energy2$Global_active_power2=as.numeric(paste(Energy2$Global_active_power))

dev.new(width=5, height=5)

png('plot2.png')

plot(Energy2$DateTime, Energy2$Global_active_power2, type="l", xlab="",
     ylab = "Global Active Power (kilowatts)")

dev.off()