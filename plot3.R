# parse source file to data frame
powercomp <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#clean data
powercomp <- transform(powercomp, DateTime = strptime(paste(as.character(Date), as.character(Time)), format = "%d/%m/%Y %H:%M:%S"))
powercomp <- transform(powercomp, Date = strptime(as.character(powercomp$Date), format = "%d/%m/%Y"))
powercomp <- powercomp[powercomp$Date >= strftime("2007-02-01"), ]
powercomp <- powercomp[powercomp$Date <= strftime("2007-02-02"), ]
powercomp <- transform(powercomp, Sub_metering_1 = as.numeric(as.character(powercomp$Sub_metering_1)))
powercomp <- transform(powercomp, Sub_metering_2 = as.numeric(as.character(powercomp$Sub_metering_2)))
powercomp <- transform(powercomp, Sub_metering_3 = as.numeric(as.character(powercomp$Sub_metering_3)))

# open png
png(file = "plot3.png", width = 480, height = 480)

# plot metering line graph
with(powercomp, plot(DateTime, Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy Sub Metering'))
with(powercomp, points(DateTime, Sub_metering_2, type = 'l', col = "red"))
with(powercomp, points(DateTime, Sub_metering_3, type = 'l', col = "blue"))
legend("topright",  lty = 1, legend = c('sub_metering_1', 'sub_metering_2', 'sub_metering_3'), col = c('black', 'red', 'blue'))

# close
dev.off()