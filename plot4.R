##____________________________________________________________________________
## Start of script
##____________________________________________________________________________

## First load the packages required to run the script.

library(tidyverse)

library(lubridate)

library(varhandle)

## Download the data to the working directory.

data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

data_file <- "exdata_data_household_power_consumption.zip"

download.file(data_url, data_file, method = "curl", quiet = TRUE)

unzip(data_file, setTimes = TRUE)

## Data has now been downloaded and released from the zip folder.

## Next load the data from the working directory.

power_data <- read.table(file = "household_power_consumption.txt",
                         header = TRUE,
                         sep = ";")

## Add a datetime column and filter by the required dates.

power_data <- power_data %>%
        mutate(Date_Time = dmy_hms(paste(Date, Time)),
               Date = dmy(Date),
               Time = hms(Time)) %>%
        filter(between(date(Date_Time), dmy("1/2/2007"), dmy("2/2/2007")))

## Convert the columns we need to plot from the factor class to their real class (numeric).

power_data[,3:9] <- unfactor(power_data[,3:9])

## Convert any missing numeric values to NA.

power_data[,3:9] <- na_if(power_data[,3:9], "?")

## Open the graphic device for PNG files.

png(file="C:/Users/BBCOLLINS/Documents/ExploratoryDataAnalysis/ExData_Plotting1/plot4.png",
    width=480, height=480)

## Plot the graph.

par(mfrow = c(2,2))

with(power_data, {
        plot(x = Date_Time, y = Global_active_power,
             type ="l",
             ylab = "Global Active Power (kilowatts)",
             xlab = "")
        plot(x = Date_Time, y = Voltage,
             type = "l",
             xlab = "datetime",
             ylab = "Voltage")
        plot(x = Date_Time, y = Sub_metering_1,
             type ="l",
             ylab = "Energy sub metering",
             xlab = "")
        lines(x = Date_Time, y = Sub_metering_2, col = "red")
        lines(x = Date_Time, y = Sub_metering_3, col = "blue")
        legend("topright",
               col = c("black", "red", "blue"),
               lty = 1,
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(x = Date_Time, y = Global_reactive_power,
             type = "l",
             xlab = "datetime",
             ylab = "Global_reactive_power")
})

## Close the graphic device.

dev.off()

##____________________________________________________________________________
## End of script
##____________________________________________________________________________