
#' @importFrom lazyeval as.lazy
lazyeval::as.lazy

#' @importFrom lazyeval f_eval
lazyeval::f_eval

#' @export
print.rabarbRa <- function(x,...){
  str(get("summary",x)())
}

#' @export
dim.rabarbRa <- function(x,...){
  get("process",x)(FUN=dim,...)
}
