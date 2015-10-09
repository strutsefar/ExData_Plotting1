#Read and tidy up the dataset (convert date and time strings to appropriate values)

df  <- read.csv("household_power_consumption.txt",na.strings = "?",sep=";",stringsAsFactors = FALSE)
df$Date  <- as.Date(df$Date,format="%d/%m/%Y") #Convert date to dateformat
df  <- subset(df,Date == "2007-02-01" | Date == "2007-02-02") #Subset to the dates we need

library(chron) #Use chron library to handle times
df$Time <- chron(times= df$Time)
df$DateTime  <- as.POSIXct(paste(df$Date,df$Time)) #Create DateTime variable to use as X axis

#Set PNG file as output
png("Plot4.PNG")


par(mfrow=c(2,2)) #Define that we want a plot with four subplots

#subplot 1
hist(df$Global_active_power,col="red",xlab="Global Active Power (Kilowatts)",main="") #Create the actual plot

#subplot 2
plot(df$DateTime,df$Voltage,type="n",ylab="Voltage",xlab="datetime")
lines(df$DateTime,df$Voltage,col="black")

#subPlot 3
plot(df$DateTime,df$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="datetime")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),cex=0.7,bty = "n" )
lines(df$DateTime,df$Sub_metering_1,col="black")
lines(df$DateTime,df$Sub_metering_2,col="red")
lines(df$DateTime,df$Sub_metering_3,col="blue")

#subplot 4
plot(df$DateTime,df$Global_reactive_power,type="n",ylab="Global_reactive_power",xlab="datetime")
lines(df$DateTime,df$Global_reactive_power,col="black")
dev.off() #Close PNG Device