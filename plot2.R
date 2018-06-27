# parse source file to data frame
powercomp <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#clean data
powercomp <- transform(powercomp, DateTime = strptime(paste(as.character(Date), as.character(Time)), format = "%d/%m/%Y %H:%M:%S"))
powercomp <- transform(powercomp, Date = strptime(as.character(powercomp$Date), format = "%d/%m/%Y"))
powercomp <- transform(powercomp, Global_active_power = as.numeric(as.character(powercomp$Global_active_power)))
powercomp <- powercomp[powercomp$Date >= strftime("2007-02-01"), ]
powercomp <- powercomp[powercomp$Date <= strftime("2007-02-02"), ]

# open png
png(file = "plot2.png", width = 480, height = 480)

# plot global active power line graph
with(powercomp, plot(DateTime, Global_active_power, type = "l", xlab = '', ylab = 'Global Active Power(kilowatts)'))

# close png 
dev.off()