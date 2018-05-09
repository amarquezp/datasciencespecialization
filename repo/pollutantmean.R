pollutantmean <- function(directory, pollutant, id=1:332){
  
  #read files from directory
  #files <- list.files(path=directory, pattern="*.csv")
  #mydataInFiles <- lapply(paste(directory, files, sep=""), read.delim)
  #mydataInFiles.noNa <- na.omit(mydataInFiles)
  mydataInFiles <- data.frame()
  for ( i in id){
    
    filename <- ""
    
    if ( i <=  9){
      filename <- paste("00",i, sep="")
    }
    else if(i >= 10 && i <=99 ){
      filename <- paste("0",i, sep="")
    }
    else{
      filename <- i
    }
    mydataInFiles <- rbind(mydataInFiles, read.csv(paste("C:/coursera/", directory, "/", filename, ".csv", sep="")))
    
  }
  mydataInFiles.noNa <- na.omit(mydataInFiles)
  colMeans(mydataInFiles.noNa[pollutant])
  
}


