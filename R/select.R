#' select_var
#'
#' select_var
#' @param x rabarbRa object
#' @param variable parameters regarding the selection method
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' select_var()
#' }
select_var <- function(x,variable){
  if(inherits(x,"rabarbRa")){
    x$select(variable=variable)
  } else stop("Need to be a rabarbRa object")
}

#' select_row
#'
#' select_row
#' @param x rabarbRa object
#' @param query parameters regarding the selection method
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' select_row()
#' }
select_row <- function(x,query){
  if(inherits(x,"rabarbRa")){
    x$select(query=query)
  } else stop("Need to be a rabarbRa object")
}

###############################################
# select_ function intern to a rabarbRa object #
###############################################
# This is a simple first version.
# This has been built to get a first algorithm architecture
# The process/algorithm/code language might be adapted soon.
# Objectives: low RAM, fast computing
select_var_ <- function(df,variable){
  if (length(variable)==1){
     return(which((names(df) == variable)) )
  } else if (length(variable)>1){
     return(unlist(lapply(variable,function(x) which(names(df) == x))))
  } else stop("variable required")
}

select_row_ <- function(df,query){
  stopifnot(inherits(query,"queries"))
  if(length(query$q)==1){
    tmp <- lapply(query$q,select_one,df=df)
    return(which(tmp[[1]]))
  } else if(length(query$q)>1){
    tmp <- lapply(query$q,select_one,df=df)
    return(which(do.call(query$logic,args=list(tmp))))
  } else stop("query object required")
}

select_one <-function(req,df){
  FUN <- get(q_fun_sign(req))
  res <- FUN(df[[q_variable(req)]],q_value(req))
  return(res)
}

AND <- function(...){
  return(elogic("&&",...))
}

OR <- function(...){
  return(elogic("||",...))
}

elogic <- function(logic,...) {
  FUN <- function(...){
     return(mapply(logic, ...))
  }
  return(do.call("FUN",args=...))
}
