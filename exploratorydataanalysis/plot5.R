##########################################################################################################
## Date: 			Oct 5, 2017
## File: 			plot5.R
## Description: 	Reads from data folder the files 'Source_Classification_Code.rds' and summarySCC_PM25.rds. 
##				Builds a PNG plot file, 
##				named 'plot5.png', corresponding
##				to the graph for 'Emissions from motor vehicle sources changed from 1999–2008 in Baltimore City'
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 2 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
#########################################################################################################

library(grDevices)
library(ggplot2)

plot5<-function(){
	
	NEI_FILE_LOCATION	<- 'data/summarySCC_PM25.rds'
	SCC_FILE_LOCATION	<- 'data/Source_Classification_Code.rds'
	NEI 				<- readRDS(NEI_FILE_LOCATION)
	SCC 				<- readRDS(SCC_FILE_LOCATION)
	
	NEI_Baltimore 					<- subset(NEI, fips=="24510")
	BALTIMORE.MotorVehicle.SCC 		<- (SCC[grep("[Motor][Veh]", SCC$Short.Name),c(1)])
	BALTIMORE.dataEmissionsMotorVeh 	<- subset(NEI_Baltimore, SCC %in% BALTIMORE.MotorVehicle.SCC)
	ggplot(BALTIMORE.dataEmissionsMotorVeh, aes(x=year, y=log10(Emissions))) + geom_point(shape=1) + geom_smooth(method=lm, color="red", se=T) + xlab("Year") + ylab("Emissions") + ggtitle("Motor vehicle Emissions sources from 1999-2008 in Baltimore")
	
	ggsave("plot5.png", device="png")
}