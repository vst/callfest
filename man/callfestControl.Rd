% Generated by roxygen2 (4.0.2): do not edit by hand
\name{callfestControl}
\alias{callfestControl}
\title{Provides a controller for the callfest applications.}
\usage{
callfestControl(FUN, N = 1, parallel = FALSE, ...)
}
\arguments{
\item{FUN}{The function to be applied.}

\item{N}{The number of repetitive applications.}

\item{parallel}{Flag if we want parallel invokations or not.}

\item{...}{Extra parameters (currently ignored).}
}
\value{
An instance of \code{callfestControl} class.
}
\description{
Provides a controller for the callfest applications.
}
\examples{
## Create a control instance:
control <- callfestControl(list, N=1, parallel=FALSE)

## Call fest:
result <- callfest(control, a=1:2, b=c("a", "b"))

## This is equivalent to:
result <- callfest(list, a=1:2, b=c("a", "b"))
}

