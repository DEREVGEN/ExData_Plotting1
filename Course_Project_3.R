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

# chart 3 -. coursera
plot(datasets$dateTime, datasets$Sub_metering_1, type='l', ylab='Energy sub metering')
lines(datasets$dateTime, datasets$Sub_metering_2, col='red')
lines(datasets$dateTime, datasets$Sub_metering_3, col='blue')
legend('topright', legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c('black', 'red', 'blue'), pch='ㅡ')

dev.copy(png, file='./plot3.png')
dev.off()