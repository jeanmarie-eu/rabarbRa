
#' @importFrom lazyeval as.lazy
lazyeval::as.lazy

#' @export
print.rabarbRa <- function(x,...){
  str(get("summary",x)())
}

#' @export
dim.rabarbRa <- function(x,...){
  get("process",x)(FUN=dim,...)
}
