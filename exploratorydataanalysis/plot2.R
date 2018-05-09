##########################################################################################################
## Date: 			Oct 5, 2017
## File: 			plot2.R
## Description: 	Reads from data folder the files 'Source_Classification_Code.rds' and summarySCC_PM25.rds. 
##				Builds a PNG plot file, 
##				named 'plot2.png', corresponding
##				to the graph for 'total PM2.5 emission from all sources for each of 
##				the years 1999, 2002, 2005, and 2008' for Baltimore
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 2 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
#########################################################################################################

library(grDevices)

plot2<-function(){
	
	NEI_FILE_LOCATION	<- 'data/summarySCC_PM25.rds'
	NEI 				<- readRDS(NEI_FILE_LOCATION)
	
	NEI_Baltimore <- subset(NEI, fips=="24510")
	totalPM2.5 <- aggregate(NEI_Baltimore$Emissions, list(NEI_Baltimore$year), sum)
	names(totalPM2.5) <- c("year", "totalPM2.5")
	
	png(filename="plot2.png", width=480, height = 480, units = 'px')
	totalPM2.5_plot <- plot(totalPM2.5$year, totalPM2.5$totalPM2.5, type="l", ylab = "Tons", xlab="Year", main= "Total emissions (PM2.5) in Baltimore, MD from 1999 to 2008 ")
	dev.off()
	
}