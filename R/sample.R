
#' sample_row
#'
#' sample_row
#' @param x rabarbRa object
#' @param n n samples
#' @param replace boolean
#' @param prob prob transition matrix
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' select_row()
#' }
sample_n <- function(x,n,replace=FALSE,prob=NULL){
  if(inherits(x,"rabarbRa")){
    indice_n(x=x,n=n,replace=replace,prob=prob)
    return(x[])
  } else stop("Need to be a rabarbRa object")
}

#' indice_n
#'
#' indice_n
#' @param x rabarbRa object
#' @param n n samples
#' @param replace boolean
#' @param prob prob transition matrix
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' indice_n()
#' }
indice_n <- function(x,n,replace=FALSE,prob=NULL){
  if(inherits(x,"rabarbRa")){
    x$indice(i=sample.int(nrow(x[]), size=n, replace = replace, prob = prob))
  } else stop("Need to be a rabarbRa object")
  invisible()
}
