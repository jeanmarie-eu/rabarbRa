
#' @export
print.rabarbRa <- function(x,...){
  str(get("summary",x)())
}

#' @export
dim.rabarbRa <- function(x,...){
  get("process",x)(FUN=dim,...)
}

#' @export
`[.rabarbRa` <- function(x,i=NULL,j=NULL){
  get("values",x)(i,j)
}

#' @export
`[<-.rabarbRa` <- function(x,i=NULL,j=NULL,value){
  #get("modify",x)(i,j,value)
  get("modify",x)(i,j,value)
  x
}
