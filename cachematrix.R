## These functions return the inverse of a matrix by either returning a cached value if it has already
## been calculated, or calculating the inverse and caching the result

## create a function which takes a matrix as an input and caches the inverse matrix
makeCacheMatrix <- function(x=matrix()){
    
    ## initialize and set the inv variable to NULL
    inv <- NULL
    
    ##create a setter function that sets the value of the matrix object (x) from the input (y)
    set <- function(y){
        
        ## set the matrix object (x) to the value of the new matrix object (y) in the parent environment
        x <<-y
        
        ## set the inv variable to NULL
        inv <<- NULL
    }
    ## create a getter function that returns the matrix object (x)
    get <- function() x
    
    ## sets the matrix inversion result (solve) to the inv variable
    setInv <- function(solve) inv <<- solve
    
    ## returns the matrix object associated with the inv variable
    getInv <- function() inv
    
    ## returns a named list of functions available in this environment
    list(set = set, get = get, setInv=setInv, getInv = getInv)
}

##create a function that requires a makeCacheMatrix object as an input and either 
##gets the value from cache (if available) or recalculates the inverse, saves to cache, and returns the value
cacheSolve <- function (x,...){
    
    ##sets the value of the local (m) variable to the makeCacheMatrix cached inverse value
    inv <- x$getInv()
    
    ##checks if a cached value exists for the inverse
    if(!is.null(inv)) {
        
        ## if it does exist, return the value and message that the value is being returned from cache
        message("getting cached data")
        return (inv)
    }
    
    ##if the cache value is NULL, get the matrix from the makeCacheMatrix object 
    data <- x$get()
    
    ##calculate the inverse of the matrix and set the result to the inv variable
    inv <- solve(data, ...)
    
    ##add the newly calculated inverse to the cache for future use
    x$setInv(inv)
    
    ## return the value of the newly calculated inverse
    inv
}
