# Set colClasses when reading in large data tables
classtest <- read.table("household_power_consumption.txt", nrows = 10, sep = ";", header = TRUE)
classes <- sapply(classtest, class)

# Read data
Data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   quote = "", na.strings = "?", colClasses = classes, 
                   nrows = 2075259, comment.char = "")

#Subset on dates
Data$Date <- as.Date(Data$Date, "%d/%m/%Y")
Dates <- as.character(Data$Date) %in% c("2007-02-01", "2007-02-02")
Subset <- Data[Dates,]

# Create a new column that contains the date + time
Subset$NewTime <- paste(Subset$Date, Subset$Time)
Subset$NewTime <- strptime(Subset$NewTime, format = "%Y-%m-%d %H:%M:%S")

# Plot3
png(filename = "plot3.png")
plot(Subset$NewTime, Subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(Subset$NewTime, Subset$Sub_metering_2, type="l", col = "red")
points(Subset$NewTime, Subset$Sub_metering_3, type="l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

