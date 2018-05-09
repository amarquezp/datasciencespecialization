##########################################################################################################
## Date: 			Oct 5, 2017
## File: 			plot3.R
## Description: 	Reads from data folder the files 'Source_Classification_Code.rds' and summarySCC_PM25.rds. 
##				Builds a PNG plot file, 
##				named 'plot3.png', corresponding
##				to the graph for 'Comparisson for PM2.5 for Baltimore City 1999-2008'
## Author: 		Antonio Marquez Palacios
## Project:		Exploratory Data Analysis Course Project 2 - coursera
## Project URL: 	https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2
#########################################################################################################

library(ggplot2)

plot3<-function(){
	
	NEI_FILE_LOCATION	<- 'data/summarySCC_PM25.rds'
	NEI 				<- readRDS(NEI_FILE_LOCATION)
	
	NEI_Baltimore <- subset(NEI, fips=="24510")
	#ggplot(NEI_Baltimore, aes(log10(Emissions), colour=type, fill=type)) + geom_density(alpha=0.55) + facet_wrap(~year)
	ggplot(NEI_Baltimore, aes(x=factor(year), y=log(Emissions), fill=factor(year))) + geom_boxplot() + facet_wrap(~type)+xlab("Year") + ylab("Emissions") + ggtitle("Comparisson for PM2.5 for Baltimore City 1999-2008") + labs(fill="Year")
	
	ggsave("plot3.png", device="png")
}