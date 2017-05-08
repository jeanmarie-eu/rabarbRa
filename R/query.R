#' query
#'
#' query
#' @param variable variable
#' @param fun_sign fun_sign
#' @param value value
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' query()
#' }
query <- function(variable,fun_sign,value){
  res <- list(variable = variable,
              fun_sign = fun_sign,
              value    = value)
  structure(res, class=c("query", class(res)))
}

#' queries
#'
#' queries
#' @param ... queries
#' @param logic logical character "AND" "OR"
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' multiquery()
#' }
queries <- function(...,logic=NULL){
  res <- list(q     = list(...),
              logic = logic)
  lapply(res$q,function(x)stopifnot(inherits(x,"query")))
  structure(res, class=c("queries", class(res)))
}



q_variable <- function(q){
  return(q$variable)
}

q_fun_sign <- function(q){
  return(q$fun_sign)
}

q_value <- function(q){
  return(q$value)
}
