##########################################################################################################
## Date: 			Oct 5, 2017
## File: 			plot1.R
## Description: 	Reads from data folder the files 'Source_Classification_Code.rds' and summarySCC_PM25.rds. 
##				Builds a PNG plot file, 
##				named 'plot1.png', corresponding
##				to the graph for 'total PM2.5 emission from all sources for each of 
##				the years 1999, 2002, 2005, and 2008'
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 2 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
#########################################################################################################

library(grDevices)

plot1<-function(){
	
	NEI_FILE_LOCATION	<- 'data/summarySCC_PM25.rds'
	SCC_FILE_LOCATION	<- 'data/Source_Classification_Code.rds'
	NEI 				<- readRDS(NEI_FILE_LOCATION)
	SCC 				<- readRDS(SCC_FILE_LOCATION)
	
	totalPM2.5 <- aggregate(NEI$Emissions, list(NEI$year), sum)
	names(totalPM2.5) <- c("year", "totalPM2.5")
	totalPM2.5$totalPM2.5 <- totalPM2.5$totalPM2.5/1000000
	png(filename="plot1.png", width=480, height = 480, units = 'px')
	totalPM2.5_plot <- plot(totalPM2.5$year, totalPM2.5$totalPM2.5, type="l", ylab = "Tons / 1000000", xlab="Year", main= "Total emissions (PM2.5) in the United States from 1999 to 2008 ")
	dev.off()

}