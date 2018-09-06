## Antonio Marquez Palacios
## Cousera Data Scientist Specialization
## Data Science Capstone
# June 11, 2018

tokenizeFileContent <- function(filePath, nlines = 1){
  
  conn <- createConnection(filePath, "r")
  
  if ( !is.null(conn) ) {
    
    print(paste("Reading ", nlines, " from file..."))
    
    line <- readLines(conn, nlines)
    
    close(conn)
    
    strsplit(line," ")
    
  }
  
  else{
    
    print(paste("unable to find file  ", filePath))
    
  }
  
}

countLinesWithToken <- function(filePath, token_str){
  
  
  numlines <- length(grep(token_str,readLines(filePath)))
  numlines

}


createConnection <- function(filePath, permissions){
  
  conn <- NULL
  print(paste("Verifying file exists", filePath))
  if ( file.exists(filePath) ){
    print(paste("Trying to open file ", filePath))
    conn <- file(filePath, permissions, blocking = FALSE)
  }
  
  conn
  
}

