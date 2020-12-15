# Load libraries to use

library(dplyr)
library(lubridate)

# Create data frame from the zip file
df <- read.table(file.choose(), sep = ";", colClasses = "character")

# Assign column names
colNames <- df[1,]
colnames(df) <- colNames

#Substract column names row
df <- df[-1,]

#Reset column names
rownames(df) <- NULL

#Create one intermediary data frame to manipulate
df1 <- df

#Change date variable's format from character to date
df1$Date <- dmy(df1$Date)

#Subset desired dates and create the final data frame
df2 <- df1 %>% filter(Date == dmy(c("01-02-2007", "02-02-2007")))

#Check for data types in each variable
str(df2)

#Change string data types to numeric
df2[,3:9] <- lapply(df2[,3:9], as.numeric)

#Create a new variable for date-time
df2$datetime <- paste(as.character(df2$Date), as.character(df2$Time))
df2$datetime <- as.POSIXct(df2$datetime)

# Plot1: Global Active Power Histogram

hist(df2$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main= "Global Active Power",
     col = "red")
png(filename = "plot1.png", width = 480, height = 480)
dev.off()