
value <- function(df,indice=NULL,field=NULL){
  if ((!is.null(indice)) && (!is.null(field))) {
     return(df[indice,field])
  } else if ((is.null(indice)) && (!is.null(field))) {
     return(df[,field])
  } else if ((!is.null(indice)) && (is.null(field))) {
    return(df[indice,])
  } else if ((is.null(indice)) && (is.null(field))) {
    stop("function need arguments.")
  }
}
