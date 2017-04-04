#' query
#'
#' query
#' @param field field
#' @param fun_sign fun_sign
#' @param value value
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' query()
#' }
query <- function(field,fun_sign,value){
  res <- list(field    = field,
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
