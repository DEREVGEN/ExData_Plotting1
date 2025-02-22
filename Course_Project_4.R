# datasets file is big, so execute code and download datasets on internet

# Loading datasets
if (!dir.exists('./datasets')) {
  dir.create('./datasets')
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url, './datasets/household_power_consumption.zip')
  unzip('./datasets/household_power_consumption.zip', exdir='./datasets')
}

datasets <- read.table('./datasets/household_power_consumption.txt', sep = ';', na.strings = "?", header=T, colClasses=c(rep("character",2),rep("numeric",7)))

library(dplyr)
# filtering date in 2007-2-1 ~ 2007-2-2
datasets <- datasets %>% filter(Date=="1/2/2007" | Date=="2/2/2007")

head(datasets)
View(datasets)

# chage column type to Date type
datasets$Date <- as.Date(datasets$Date, format='%d/%m/%Y')
View(datasets)
str(datasets)

library(lubridate)

datasets$dateTime <- as_datetime(paste(datasets$Date, datasets$Time))
datasets$dateTime
str(datasets)


# chart 4 -. coursera
par(mfrow = c(2,2), mar=c(4.5,4,3,1.5))
plot(datasets$dateTime, datasets$Global_active_power, type='l', ylab='Global Active Power(kilowatts)', xlab='')

plot(datasets$dateTime, datasets$Voltage, type='l', ylab='Voltage', xlab='datetime')

plot(datasets$dateTime, datasets$Sub_metering_1, type='l', ylab='Energy sub metering', xlab='')
lines(datasets$dateTime, datasets$Sub_metering_2, col='red')
lines(datasets$dateTime, datasets$Sub_metering_3, col='blue')
legend('topright', legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", col=c('black', 'red', 'blue'), pch='ㅡ')

plot(datasets$dateTime, datasets$Global_reactive_power, type='l', ylab='Global_reactive_power', xlab='datetime')

dev.copy(png, file='./plot4.png')
dev.off()