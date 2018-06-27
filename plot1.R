# parse source file to data frame
powercomp <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#clean data
powercomp <- transform(powercomp, Date = strptime(as.character(powercomp$Date), format = "%d/%m/%Y"))
powercomp <- powercomp[powercomp$Date >= strftime("2007-02-01"), ]
powercomp <- powercomp[powercomp$Date <= strftime("2007-02-02"), ]
powercomp <- transform(powercomp, Global_active_power = as.numeric(as.character(powercomp$Global_active_power)))

# open png
png(file = "plot1.png", width = 480, height = 480)

# plot histogram for plot 1
hist(powercomp$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

# close png 
dev.off()