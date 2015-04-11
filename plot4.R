setwd("~/Coursera/Exploratory Data Analysis")

Cwd = getwd()

pro_Folder <- "Course project 1"

dir.create(file.path(Cwd, pro_Folder), showWarnings = FALSE)

wd <- paste(Cwd,pro_Folder, sep="/")

setwd(wd)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Machine_learning.zip")

list.files()

tmpdir=unzip("Machine_learning.zip")

#Read the name of the columns from data file
tmp_names <- names(read.table(tmpdir, nrows = 1000, sep = ";", header = TRUE, na.strings = "?"))

#read approximately the lines we need 
tmp <- read.table(tmpdir, nrows = 5000, sep = ";", header = TRUE, na.strings = "?", skip = 65000)

names(tmp) <- tmp_names

#convert columns to dates and timestamp

tmp$Date <- as.Date(tmp$Date, format = "%d/%m/%y%y")
#timestamp
tmp$Time<- strptime(paste(tmp$Date,tmp$Time),format = '%y%y-%m-%d %H:%M:%S')

#lets select only the dates of interest 

tmp<-tmp[tmp$Date == "2007-02-02" | tmp$Date == "2007-02-01",]

str(tmp)
summary(tmp)
dim(tmp)

# we can see 2880 observation now lets plot the histogram chart the png file 1
#hist(tmp$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")

#Define langueage settings for right axis 
Sys.setlocale("LC_ALL","C")
#change bacek with 
Sys.getlocale()

# now we construct the last plot and save it as plot4.png
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
#par(mar = c(6,4,1,4))

#1,1
plot(tmp$Time,tmp$Global_active_power, col="black", main="", ylab = "Global Active Power",xlab = "",type="l")
#1,2
plot(tmp$Time,tmp$Voltage, col="black",lwd = "0.1", main="", ylab = "Voltage",xlab = "datetime",type="l")
#2,1
plot(tmp$Time,tmp$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", col = "black")
points(tmp$Time,tmp$Sub_metering_2, type = "l", ylab = "Energy sub metering", xlab="", col = "red")
points(tmp$Time,tmp$Sub_metering_3, type = "l", ylab = "Energy sub metering", xlab="", col = "blue")
legend("topright",bty="n", cex = 0.9, lwd=0, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
#2.2
plot(tmp$Time,tmp$Global_reactive_power, col="black",lwd = "0.1", main="", ylab = "Global_reactive_power",xlab = "datetime",type="l")
dev.off()
