
complete <- function(directory, id=1:332){
  
  df <- data.frame(id=numeric(), nobs=numeric())
  
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
    completeCases <- na.omit(readDf)
    df <- rbind(df, data.frame(id=i, nobs=length(completeCases[[1]])))
    
  }
  
  df
}