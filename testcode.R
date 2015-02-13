
# Test code

# generate matrix, and the inverse of the matrix.
size <- 1000 # size of the matrix edge, don't make this too big
mymatrix <- matrix(rnorm(size^2), nrow=size, ncol=size)
mymatrix.inverse <- solve(mymatrix)

# now solve the matrix via the cache-method

special.matrix   <- makeCacheMatrix(mymatrix)

# this should take long, since it's the first go
special.solved.1 <- cacheSolve(special.matrix)

# this should be lightning fast
special.solved.2 <- cacheSolve(special.matrix)

# check if all solved matrices are identical
identical(mymatrix.inverse, special.solved.1) & identical(mymatrix.inverse, special.solved.2)

# should return TRUE


# now for something completely different..

size <- 3
matrix.one <- matrix(rnorm(size^2), nrow=size, ncol=size)

size <- 4
matrix.two <- matrix(rnorm(size^2), nrow=size, ncol=size)

matrix.one.cacheable  <- makeCacheMatrix(matrix.one)

# this returns the inverse of matrix.one. A 3x3 matrix
cacheSolve(matrix.one.cacheable)

# great, let's do it again!
matrix.two.cacheable <- makeCacheMatrix(matrix.two)
# this returns the inverse of matrix.two. A 4x4 matrix
cacheSolve(matrix.two.cacheable)

# now let's do matrix.one again.
cacheSolve(matrix.one.cacheable)

# ooops! -> this returned a 4x4?

the.cache <- NULL # replace this by the name you gave it in the makeCacheMatrix function

# this works: a 3x3 inverse of matrix.one
cacheSolve(matrix.one.cacheable)





