##########################################################################################################
## Date: 			Sep 17, 2017
## File: 			plot4.R
## Description: 	Reads from 'data' folder the file 'household_power_consumption.txt'. In order to 
## 				save memory, it reads 2881 rows starting from
##				row 66636, which corresponds to dates 1/2/2007-2/2/2007. Builds a PNG plot file, 
##				named 'plot4.png', corresponding to 4 graphs for different types of 
##				analysis:
##				- Global Active Power over datetime
##				- Voltage
##				- Energy submetering
##				- Global Reactive  Power over datetime
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 1 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1
#########################################################################################################

library(grDevices)

plot4<-function(){
	
	HOUSEHOLD_POWER_CONSUMPTION_FILE <- "data/household_power_consumption.txt"
	HEADERS_NAMES <- c('DATE', 'TIME', 'GLOBAL_ACTIVE_POWER','GLOBAL_REACTIVE_POWER', 'VOLTAGE','GLOBAL_INTENSITY','SUB_MET1', 'SUB_MET2', 'SUB_MET3')
	
	powerConsumptionDT <- read.table(file=HOUSEHOLD_POWER_CONSUMPTION_FILE,sep = ';', header = TRUE, skip = 66636, nrows=2881, na.strings = '?' )
	names(powerConsumptionDT)<- HEADERS_NAMES
	
	powerConsumptionDT$DATE	<- as.Date(powerConsumptionDT$DATE, '%d/%m/%Y')
	
	powerConsumptionDT$DATETIME <- strptime(paste(powerConsumptionDT$DATE,powerConsumptionDT$TIME), format='%Y-%m-%d %H:%M:%S')
	
	
	png(filename="plot4.png", width=480, height = 480, units = 'px')
	par(mfrow=c(2,2))
	#Graph 1: 
	plot(powerConsumptionDT$DATETIME, powerConsumptionDT$GLOBAL_ACTIVE_POWER, type = "l", col="black", ylab = "Global Active Power", xlab = "")
	
	#Graph 2:
	plot(powerConsumptionDT$DATETIME, powerConsumptionDT$VOLTAGE, type = "l", col="black", ylab = "Voltage", xlab = "datetime")
	
	#Graph 3:
	plot(powerConsumptionDT$DATETIME, powerConsumptionDT$SUB_MET1, type="n", ylab = "Energy sub metering", xlab =  "")
	points(as.numeric(powerConsumptionDT$DATETIME), powerConsumptionDT$SUB_MET1, type = "l", col="black")
	points(as.numeric(powerConsumptionDT$DATETIME), powerConsumptionDT$SUB_MET2, type = "l", col="red")
	points(as.numeric(powerConsumptionDT$DATETIME), powerConsumptionDT$SUB_MET3, type = "l", col="blue")
	legend("topright", pch=c("l", "l", "l"), col=c("black", "red", "blue"), legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3") )
	
	#Graph 4
	plot(powerConsumptionDT$DATETIME, powerConsumptionDT$GLOBAL_REACTIVE_POWER, type = "l", col="black", ylab = "Global_reactive_power", xlab = "datetime")
	
	dev.off()
	
}