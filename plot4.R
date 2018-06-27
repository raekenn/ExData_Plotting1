# parse source file to data frame
powercomp <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# clean data
powercomp <- transform(powercomp, DateTime = strptime(paste(as.character(Date), as.character(Time)), format = "%d/%m/%Y %H:%M:%S"))
powercomp <- transform(powercomp, Date = strptime(as.character(powercomp$Date), format = "%d/%m/%Y"))
powercomp <- powercomp[powercomp$Date >= strftime("2007-02-01"), ]
powercomp <- powercomp[powercomp$Date <= strftime("2007-02-02"), ]
powercomp <- transform(powercomp, Sub_metering_1 = as.numeric(as.character(powercomp$Sub_metering_1)))
powercomp <- transform(powercomp, Sub_metering_2 = as.numeric(as.character(powercomp$Sub_metering_2)))
powercomp <- transform(powercomp, Sub_metering_3 = as.numeric(as.character(powercomp$Sub_metering_3)))
powercomp <- transform(powercomp, Global_active_power = as.numeric(as.character(powercomp$Global_active_power)))
powercomp <- transform(powercomp, Global_reactive_power = as.numeric(as.character(powercomp$Global_reactive_power)))
powercomp <- transform(powercomp, Voltage = as.numeric(as.character(powercomp$Voltage)))

# open png
png(file = "plot4.png", width = 480, height = 480)

# plot 4 graphs
par(mfcol = c(2,2))
# plot top left
with(powercomp, plot(DateTime, Global_active_power, type = "l", xlab = '', ylab = 'Global Active Power'))
# plot bottom left
with(powercomp, plot(DateTime, Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy Sub Metering'))
with(powercomp, points(DateTime, Sub_metering_2, type = 'l', col = "red"))
with(powercomp, points(DateTime, Sub_metering_3, type = 'l', col = "blue"))
legend("topright",  lty = 1, legend = c('sub_metering_1', 'sub_metering_2', 'sub_metering_3'), col = c('black', 'red', 'blue'))
# plot top right
with(powercomp, plot(DateTime, Voltage, type = "l", xlab = 'datetime', ylab = 'Voltage'))
# plot bottom right
with(powercomp, plot(DateTime, Global_reactive_power, type = "l", xlab = 'datetime', ylab = 'Global_reactive_power'))

# close png
dev.off()
