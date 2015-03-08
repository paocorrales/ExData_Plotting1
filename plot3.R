#The original data base is very large. This code will read only de rows in the interval 
#1/2/2017 - 2/2/2007
#Read only the first column "Date" from de .txt 

ColDate<- read.table("household_power_consumption.txt", header=TRUE, sep= ";", 
                     colClasses= c(rep("character", 1), rep("NULL", 8)), na.strings= "?")

#creat a vector wich the interval
Import<- c("1/2/2007", "2/2/2007")
#Rows is a logical vector with TRUE if the date is in the interval
Rows<- ColDate$Date %in% Import

firstRow<- which.max(Rows)
totalRows<- sum(Rows)

#DataEner is a data frame of 9 columns and totalRows rows (only de interval)
DataEner<- read.table("household_power_consumption.txt", col.names=c("Date","Time","Global_active_power",
                                                                     "Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                      sep=";", skip= firstRow, nrows=totalRows, na.strings="?")

#Set de class of a new variable DateTime 
DateTime<- paste(DataEner$Date, DataEner$Time, sep=" ")
DateTime<- strptime(DateTime, format= "%d/%m/%Y %H:%M:%S")
DataEner$DateTime<- DateTime

#plot
png("plot3.png")
plot(DataEner[,10], DataEner[,7], type= "l", xlab= "", ylab="Energy sub metering")
lines(DataEner[,10], DataEner[,8], col="red")
lines(DataEner[,10], DataEner[,9], col="blue")
legend("topright", legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, col= c("black", "red", "blue"))
dev.off()
