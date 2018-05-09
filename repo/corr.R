corr <- function(directory, threshold=0){
  
  completeData <- complete(directory)
  ids <- completeData[which(completeData$nobs > threshold), ]
  
  for(i in id){
    
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
    
    readDf <- read.csv(paste("C:/coursera/", directory, "/", filename, ".csv", sep=""))
    sulfateCases <- na.omit(readDf$sulfate)
    sulfateCases <- na.omit(readDf$sulfate)
    df <- rbind(df, data.frame(id=i, nobs=length(completeCases[[1]])))
    
  }
    
  
}

