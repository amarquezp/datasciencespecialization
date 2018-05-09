##########################################################################################################
## Date: 			Sep 17, 2017
## File: 			plot2.R
## Description: 	Reads from 'data' folder the file 'household_power_consumption.txt'. In order to 
## 				save memory, it reads 2881 rows starting from
##				row 66636, which corresponds to dates 1/2/2007-2/2/2007. Builds a PNG plot file, 
##				named 'plot2.png', corresponding to the graph for 'Global Active Power (kilowatts)' per day
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 1 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1
#########################################################################################################
library(grDevices)

plot2<-function(){
	
	HOUSEHOLD_POWER_CONSUMPTION_FILE <- "data/household_power_consumption.txt"
	HEADERS_NAMES <- c('DATE', 'TIME', 'GLOBAL_ACTIVE_POWER','GLOBAL_REACTIVE_POWER', 'VOLTAGE','GLOBAL_INTENSITY','SUB_MET1', 'SUB_MET2', 'SUB_MET3')
	
	powerConsumptionDT <- read.table(file=HOUSEHOLD_POWER_CONSUMPTION_FILE,sep = ';', header = TRUE, skip = 66636, nrows=2880, na.strings = '?' )
	names(powerConsumptionDT)<- HEADERS_NAMES
	
	powerConsumptionDT$DATE	<- as.Date(powerConsumptionDT$DATE, '%d/%m/%Y')
	
	powerConsumptionDT$DATETIME <- strptime(paste(powerConsumptionDT$DATE,powerConsumptionDT$TIME), format='%Y-%m-%d %H:%M:%S')
	
	
	png(filename="plot2.png", width=480, height = 480, units = 'px')
	plot(powerConsumptionDT$DATETIME,powerConsumptionDT$GLOBAL_ACTIVE_POWER, ylab="Global Active Power (kilowatts)", type="l")
	dev.off()
	
}