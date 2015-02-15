## Matrix inversion is usually a costly computation and there may be some benefit to
## caching the inverse of a matrix rather than computing it repeatedly

## This file contains a pair of functions that cache the inverse of a matrix.

## example test code:
# 
# size <- 1000 # size of the matrix edge
# mymatrix <- matrix(rnorm(size^2), nrow=size, ncol=size)
#
# special.matrix   <- makeCacheMatrix(mymatrix)
# special.solved.1 <- cacheSolve(special.matrix) # this should take long
# special.solved.2 <- cacheSolve(special.matrix) # this will produce a message, and be quick
#
# identical(mysolved, special.solved.1) & identical(mysolved, special.solved.2)
# should return TRUE


## makeCacheMatrix: This function returns an list of functions that can
## operate on a matrixcreates a special "matrix" object that can be used to look up a
## cached version of the inverse (or create one)

makeCacheMatrix <- function(original.matrix = matrix()) {
  
  # we create an object in ENV where we store the solved matrix
  # At first, we start out without nothing
  the.cache <<- NULL
  
  # the get.original function returns the original matrix object, so the cacheSolve knows what to solve
  get.original <- function() original.matrix

  # the overwrite.cache function overwrites the cache
  overwrite.cache <- function(solved.matrix) {
    the.cache <<- solved.matrix
  }
  
  # the get.cached.version function returns the currently cached version of the solution.
  # this could be NULL if the matrix has never been solved
  get.cached.version <- function() the.cache
  
  # you can call the functions in makeCacheMatrix by accessing the list elements 
  list(get.original    = get.original,
       overwrite.cache = overwrite.cache,
       get.from.cache  = get.cached.version)
}

## cacheSolve: This function computes the inverse of the special "matrix" returned by
## makeCacheMatrix above.
## If the inverse has already been calculated (and the matrix has not changed), then
## cacheSolve should retrieve the inverse from the cache.

cacheSolve <- function(cachematrix.object, ...) {
   ## Return a matrix that is the inverse of the matrix that was passed to the makecachematrix
   ## function.
   ## input: a list, made by MakeCacheMatrix
  
  # check the cache
  the.cache <- cachematrix.object$get.from.cache()
  
  if(!is.null(the.cache)) {
    # bingo, there is something in cache. Return it blindly. Caller's risk. :)
    return(the.cache)
  }
  
  # no cached version, so get original matrix
  data <- cachematrix.object$get.original()
  # and store the inverse in cache
  the.cache <- solve(data)
  
  # overwrite the cache with the freshly solved matrix
  cachematrix.object$overwrite.cache(the.cache)
  
  # finally, return the freshly solved matrix, which is now in cache
  the.cache
}




