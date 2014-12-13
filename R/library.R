##' Provides a controller for the callfest applications.
##'
##' @param FUN The function to be applied.
##' @param N The number of repetitive applications.
##' @param parallel Flag if we want parallel invokations or not.
##' @param ... Extra parameters (currently ignored).
##' @return An instance of \code{callfestControl} class.
##' @examples
##' ## Create a control instance:
##' control <- callfestControl(list, N=1, parallel=FALSE)
##'
##' ## Call fest:
##' result <- callfest(control, a=1:2, b=c("a", "b"))
##'
##' ## This is equivalent to:
##' result <- callfest(list, a=1:2, b=c("a", "b"))
##' @export
callfestControl <- function (FUN, N=1, parallel=FALSE, ...) {
  ## Prepare the return value:
  retval <- list(FUN=FUN, N=N, parallel=parallel)

  ## Attach class:
  class(retval) <- "callfestControl"

  ## Done, return:
  retval
}

##' Calls a function over a list of arguments which are combinations
##' of the provided dotted arguments.
##'
##' @param control A \code{callfestControl} object of a function to be
##' applied to combinations.
##' @param ... List of arguments which will be used for combinations.
##' @return An instance of class \code{callfest} which encapsulates
##' results and the elapsed time.
##' @examples
##' ## Create a control instance:
##' control <- callfestControl(list, N=1, parallel=FALSE)
##'
##' ## Call fest:
##' result <- callfest(control, a=1:2, b=c("a", "b"))
##'
##' ## This is equivalent to:
##' result <- callfest(list, a=1:2, b=c("a", "b"))
##' @import parallel
##' @export
callfest <- function (control, ...) {
  ## Check the control:
  if (!inherits(control, "callfestControl")) {
    control <- callfestControl(FUN=control)
  }

  ## Get arguments domain:
  domain <- list(...)

  ## Create the combinations:
  combinations <- do.call(expand.grid, domain)

  ## Get arguments:
  arguments <- lapply(1:NROW(combinations),
                      function (i) {
                        as.list(combinations[i,])
                      })

  ## Get the map function:
  cfapply <- lapply
  if (control$parallel) {
    cfapply <- mclapply
  }

  ## Iterate over combinations and apply function to each argument:
  elapsed <- system.time(results <- cfapply(arguments, function (x) {
    ## Check how many times:
    if (control$N == 1) {
      ## Apply only once:
      do.call(control$FUN, x)
    }
    else {
      ## Apply the function N times and return:
      lapply(1:control$N, function (k) {
        do.call(control$FUN, x)
      })
    }
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
