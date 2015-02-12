## Matrix inversion is usually a costly computation and there may be some benefit to
## caching the inverse of a matrix rather than computing it repeatedly

## This file contains a pair of functions that cache the inverse of a matrix.

## example test code:
# 
# size <- 5000 # size of the matrix edge
# mymatrix <- matrix(rnorm(size^2), nrow=size, ncol=size)
#
# special.matrix   <- makeCacheMatrix(mymatrix)
# special.solved.1 <- cacheSolve(special.matrix) # this should take long
# special.solved.2 <- cacheSolve(special.matrix) # this will produce a message, and be quick
#
# identical(mysolved, special.solved.1) & identical(mysolved, special.solved.2)
# should return TRUE

## makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  m <<- NULL
  get <- function() x
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  inverse <- function(solve.it) m <<- solve.it
  get.inverse <- function() m
  
  list(set = set, get = get,
       inverse = inverse,
       get.inverse = get.inverse)
}

## cacheSolve: This function computes the inverse of the special "matrix" returned by
## makeCacheMatrix above.
## If the inverse has already been calculated (and the matrix has not changed), then
## cacheSolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
   ## Return a matrix that is the inverse of 'x'
  m <- x$get.inverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data)
  x$inverse(m)
  m
}




