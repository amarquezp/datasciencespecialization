##########################################################################################################
## Date: 			Oct 5, 2017
## File: 			plot6.R
## Description: 	Reads from data folder the files 'Source_Classification_Code.rds' and summarySCC_PM25.rds. 
##				Builds a PNG plot file, 
##				named 'plot6.png', corresponding
##				to the graph for 'Comparisson for motor vehicle sources from 1999-2008 between Baltimore City and L.A. County'
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 2 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
#########################################################################################################

library(grDevices)
library(ggplot2)

plot6<-function(){
	
	NEI_FILE_LOCATION	<- 'data/summarySCC_PM25.rds'
	SCC_FILE_LOCATION	<- 'data/Source_Classification_Code.rds'
	NEI 				<- readRDS(NEI_FILE_LOCATION)
	SCC 				<- readRDS(SCC_FILE_LOCATION)
	
	NEI_LA_BAL 					<- subset(NEI, fips %in% c("24510", "06037"))
	NEI_LA_BAL$City[NEI_LA_BAL$fips == '06037'] <- 'L.A.'
	NEI_LA_BAL$City[NEI_LA_BAL$fips == '24510'] <- 'Baltimore'
	MotorVehicle.SCC <- (SCC[grep("[Motor][Veh]", SCC$Short.Name),c(1)])
	
	LA_BAL.dataEmissionsMotorVeh 	<- subset(NEI_LA_BAL, SCC %in% MotorVehicle.SCC)
	ggplot(LA_BAL.dataEmissionsMotorVeh, aes(x=fips, y=(Emissions), colour=City, fill=City)) + geom_col() + facet_wrap(~year) + xlab("City") + ylab("Emissions") + ggtitle("Motor vehicle Emissions from 1999-2008 (Baltimore vs L.A.)")

	
	ggsave("plot6.png", device="png")
}