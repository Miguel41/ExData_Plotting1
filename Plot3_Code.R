library(data.table)

# First of all load the dataset into a table instead to a df (spead++)
dt <- fread(file = file.path(getwd(), "household_power_consumption.txt"),
            sep = ";",
            header = TRUE,
            na.strings = "?")

# Change to date format the Date column
dt[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Select only the data from the dates 2007-02-01 and 2007-02-02
dt <- dt[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Create one column with the date and time in POSIXct format
dt[, DateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

# Change to numeric the values
dt[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
dt[, Global_reactive_power := lapply(.SD, as.numeric), .SDcols = c("Global_reactive_power")]
dt[, Voltage := lapply(.SD, as.numeric), .SDcols = c("Voltage")]
dt[, Global_intensity := lapply(.SD, as.numeric), .SDcols = c("Global_intensity")]
dt[, Sub_metering_1 := lapply(.SD, as.numeric), .SDcols = c("Sub_metering_1")]
dt[, Sub_metering_2 := lapply(.SD, as.numeric), .SDcols = c("Sub_metering_2")]
dt[, Sub_metering_3 := lapply(.SD, as.numeric), .SDcols = c("Sub_metering_3")]



# PLOT 3. Sub_metering plot
png("plot3.png",  width=480, height=480)

plot(y = dt[, Sub_metering_1],
     x = dt[, DateTime],
     col = "black", 
     type = "l",
     ylab = "Energy sub metering",
     xlab = "Note: Xticks labels in Spanish format")

lines(y = dt[, Sub_metering_2],
      x = dt[, DateTime],
      col = "red")

lines(y = dt[, Sub_metering_3],
      x = dt[, DateTime],
      col = "blue")

legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty = c(1,1),
       lwd = c(2,2))

dev.off()
