##' Calls a function over a list of arguments which are combinations
##' of the provided dotted arguments.
##'
##' @param FUN The function to be applied to combinations.
##' @param ... List of arguments which will be used for combinations.
##' @return An instance of class \code{callfest} which encapsulates
##' results and the elapsed time.
##' @export
callfest <- function (FUN, ...) {
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
    ## Apply the function and return:
    do.call(FUN, x)
  }))

  ## Prepare the return value:
  attr(results, "time") <- elapsed

  ## Change the class:
  class(results) <- "callfest"

  ## Done, return the value:
  results
}

##' Pretty prints the \code{callfest} instance
##'
##' @param x A \code{callfest} instance to be pretty printed.
##' @param ... Additional arguments to print method.
##' @return NULL
##' @export
print.callfest <- function (x, ...) {
  ## Get the results and strip attributes:
  results <- unclass(x)
  attributes(results) <- NULL

  ## Print results
  print(results, ...)

  ## Print elapsed time:
  cat(sprintf("Elapsed %f seconds\n", attr(x, "time")["elapsed"]))
}
