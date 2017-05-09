
###############################################
# modify_ function intern to a rabarbRa object #
###############################################
# This is a simple first version.
# This has been built to get a first algorithm architecture
# The process/algorithm/code language might be adapted soon.
# Objectives: low RAM, fast computing

'modify_<-' <- function(df,i=NULL,j=NULL,value){
  if ((!is.null(i)) && (!is.null(j))) {
     df[i,j] <- value
  } else if ((is.null(i)) && (!is.null(j))) {
     df[,j] <- value
  } else if ((!is.null(i)) && (is.null(j))) {
     df[i,] <- value
  } else if ((is.null(i)) && (is.null(j))) {
     df <- value
  } else stop("problem with i and j")
  return(df)
}
