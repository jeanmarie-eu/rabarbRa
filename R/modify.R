
'modify_<-' <- function(df,i=NULL,j=NULL,value){
  if ((!is.null(i)) && (!is.null(j))) {
     df[i,j] <- value
  } else if ((is.null(i)) && (!is.null(j))) {
     df[,j] <- value
  } else if ((!is.null(i)) && (is.null(j))) {
     df[i,] <- value
  } else if ((is.null(i)) && (is.null(j))) {
     df <- value
  } else stop("problem wtih i and j")
  return(df)
}
