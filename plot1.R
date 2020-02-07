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

png(file="C:/Users/BBCOLLINS/Documents/ExploratoryDataAnalysis/ExData_Plotting1/plot1.png",
    width=480, height=480)

## Plot the graph.

with(power_data,
     hist(Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = 2))

## Close the graphic device.

dev.off()

##____________________________________________________________________________
## End of script
##____________________________________________________________________________
