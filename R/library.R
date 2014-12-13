##' Calls a function over a list of arguments which are combinations
##' of the provided dotted arguments.
##'
##' @param ... List of arguments which will be used for combinations.
##' @param FUN The function to be applied to combinations.
##' @param N The number of function invokations to each of combinations.
##' @return An instance of class \code{callfest} which encapsulates
##' results and the elapsed time.
##' @export
callfest <- function (..., FUN=list, N=1) {
  ## Get argument list:
  arguments <- list(...)

  ## Create argument combinations, iterate over them and prepare as
  ## list of arguments:
  combinations <- apply(do.call(expand.grid, arguments),
                     MARGIN=1,
                     function (x) {
                       lapply(x, unlist)
                     })

  ## Iterate over combinations and apply function to each argument:
  elapsed <- system.time(results <- lapply(combinations, function (x) {
    ## Apply N times:
    results <- lapply(1:N, function (i) do.call(FUN, x))

    ## Return the elapsed time and result seperately:
    results
  }))

  ## Prepare the return value:
  retval <- list(elapsed=elapsed, results=results)

  ## Change the class:
  class(retval) <- "callfest"

  ## Done, return the value:
  retval
}

##' Pretty prints the \code{callfest} instance
##'
##' @param x A \code{callfest} instance to be pretty printed.
##' @param ... Additional arguments to print method.
##' @return NULL
##' @export
print.callfest <- function (x, ...) {
  ## Get all results:
  results <- x$results

  ## Print results
  print(results, ...)

  ## Print elapsed time:
  cat(sprintf("Elapsed %f seconds\n", x$elapsed["elapsed"]))
}
