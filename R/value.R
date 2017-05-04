
value_ <- function(df,i=NULL,j=NULL){
  if ((!is.null(i)) && (!is.null(j))) {
     return(df[i,j])
  } else if ((is.null(i)) && (!is.null(j))) {
     return(df[,j])
  } else if ((!is.null(i)) && (is.null(j))) {
    return(df[i,])
  } else if ((is.null(i)) && (is.null(j))) {
    return(df)
  }
}
