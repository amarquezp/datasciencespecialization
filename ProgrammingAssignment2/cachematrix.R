## Antonio Marquez Palacios
## Cousera Data Scientist Specialization
## Programming Assignment 2: Lexical Scoping
# July 23, 2017

## As per Programming Assignment 2: Lexical Scoping of the Data Scientist Specialization
## This function is intended to create a special "matrix" object that can cache its inverse

## function :  makeCacheMatrix
## arguments: 'x' as a matrix object
## returns  : a special object 'matrix' which is a list of functions for caching the inverse value
## usage    : B <- makeCacheMatrix(matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, ncol=3))

makeCacheMatrix <- function(x = matrix()) {
  
  m <- NULL
  
  set <- function(y){
    
    x <<- y
    m <<- NULL
    
  }
  
  get <- function() x
  setinverse <- function(solve) m <<- solve
  getinverse <- function() m
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)

}


## function : cacheSolve
## agruments: x: a matrix created with makeCacheMatrix() function
## returns  : the inverse of the given matrix
## usage    : cacheSolve(B)
## NOTE     : it is assumed 'x' to be an invertible matrix

cacheSolve <- function(x, ...) {
  
  m <- x$getinverse()
  
  if( !is.null(m) ){
    
    message("inverse is cached, returning from cache")
    return(m)
    
  }
  
  data <- x$get()
  m <- solve(data)
  x$setinverse(m)
  m
  
        
}
