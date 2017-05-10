#' select
#'
#' select
#' @param x rabarbRa object
#' @param subset logical expression indicating elements or rows to keep: missing values are taken as false
#' @param variable expression, indicating variables to select.
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' select()
#' }
select <- function(x,subset,variable){
  if(inherits(x,"rabarbRa")){
    x$select(subset=subset,variable=variable)
  } else stop("Need to be a rabarbRa object")
}

###############################################
# select_ function intern to a rabarbRa object #
###############################################
# This is a simple first version.
# This has been built to get a first algorithm architecture
# The process/algorithm/code language might be adapted soon.
# Objectives: low RAM, fast computing

select_ <- function(df,subset,variable){
  res <-list(i=NULL,j=NULL)
  if (!missing(subset)) {
      res$i = select_i(df=df,subset)
  }
  if (!missing(variable)) {
      res$j = select_j(df=df,variable)
  }
  return(res)
}

select_i <- function(df,subset) {
  if (missing(subset)) {
      i_bool <- NULL #rep_len(TRUE, nrow(df))
  } else {
      e <- as.lazy(subset)
      i_bool <- eval(e$expr, df)
      if (!is.logical(i_bool)) stop("'subset' must be logical")
      i_bool <- (i_bool & !is.na(i_bool))
  }
  return(which(i_bool))
}

select_j <- function(df,variable=NULL) {
   if (missing(variable)) {
        j<-NULL
   } else {
        tmp <- as.list(seq_along(df))
        names(tmp) <- names(df)
        e <- as.lazy(variable)
        j <- eval(e$expr, tmp)
   }
   return(j)
}


#############
# OBSOLETE  #
#############
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
