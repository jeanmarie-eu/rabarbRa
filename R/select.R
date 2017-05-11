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
      i_bool <- rep_len(TRUE, nrow(df))
  } else {
      e <- as.lazy(subset)
      row <- eval(e$expr, df)
      if (is.logical(row)) {
        row <- (row & !is.na(row))
        return(which(row))
      } else if(is.integer(row)){
        return(row)
      } else stop("'subset' must be either logical or integer")
  }
}

select_j <- function(df,variable=NULL) {
   if (missing(variable)) {
        j<-TRUE
   } else {
        tmp <- as.list(seq_along(df))
        names(tmp) <- names(df)
        e <- as.lazy(variable)
        j <- eval(e$expr, tmp)
   }
   return(j)
}
