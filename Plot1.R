#Read and tidy up the dataset (convert date and time strings to appropriate values)

df  <- read.csv("household_power_consumption.txt",na.strings = "?",sep=";",stringsAsFactors = FALSE)
df$Date  <- as.Date(df$Date,format="%d/%m/%Y") #Convert date to dateformat
df  <- subset(df,Date == "2007-02-01" | Date == "2007-02-02") #Subset to the dates we need

library(chron) #Use chron library to handle times
df$Time <- chron(times= df$Time)

#Set PNG file as output
png("Plot1.PNG")
hist(df$Global_active_power,col="red",xlab="Global Active Power (Kilowatts)",main="Global Active Power") #Create the actual plot
dev.off() #Close PNG Device

