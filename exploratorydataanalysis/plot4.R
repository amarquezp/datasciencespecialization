##########################################################################################################
## Date: 			Oct 5, 2017
## File: 			plot4.R
## Description: 	Reads from data folder the files 'Source_Classification_Code.rds' and summarySCC_PM25.rds. 
##				Builds a PNG plot file, 
##				named 'plot4.png', corresponding
##				to the graph for 'emissions from coal combustion-related sources changed from 1999–2008 in US'
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 2 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
#########################################################################################################

library(grDevices)
library(ggplot2)

plot4<-function(){
	
	NEI_FILE_LOCATION	<- 'data/summarySCC_PM25.rds'
	SCC_FILE_LOCATION	<- 'data/Source_Classification_Code.rds'
	NEI 				<- readRDS(NEI_FILE_LOCATION)
	SCC 				<- readRDS(SCC_FILE_LOCATION)
	
	coalSCC <- SCC[grep("Coal", SCC$Short.Name),c(1)]
	
	US.dataEmissionsForCoal <- subset(NEI, SCC %in% coalSCC)
	ggplot(US.dataEmissionsForCoal, aes(ymin=0)) + geom_rect(aes(xmin=year, xmax=year+3, ymax=(Emissions), colour=factor(year), fill=factor(year))) + xlab("Year") + ylab("Emissions(Tons x 1000000)") + ggtitle("Coal Combustion-related Emissions from 1999-2008 in US")
	
	ggsave("plot4.png", device="png")
}