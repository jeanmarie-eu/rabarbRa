
#' @export
`[.rabarbRa` <- function(x,i=NULL,j=NULL){
  get("values",x)(i,j)
}

#' @export
`[<-.rabarbRa` <- function(x,i=NULL,j=NULL,value){
  #get("modify",x)(i,j,value)
  get("modify",x)(i,j,value)
  x
}


###############################################
# value_ function intern to a rabarbRa object #
###############################################
# This is a simple first version.
# This has been built to get a first algorithm architecture
# The process/algorithm/code language might be adapted soon.
# Objectives: low RAM, fast computing

value_ <- function(df,indice_select=list(i=NULL,j=NULL),i=NULL,j=NULL){
  if ( (!is.null(indice_select$i)) || (!is.null(indice_select$j)) ) {
    if ((!is.null(indice_select$i)) && (!is.null(indice_select$j))) {
       return(value_df(df,i=indice_select$i,j=indice_select$j))
    } else if ((!is.null(indice_select$i)) && (!is.null(j))) {
      return(value_df(df,i=indice_select$i,j=j))
    } else if ((!is.null(i)) && (!is.null(indice_select$j))) {
      return(value_df(df,i=i,j=indice_select$j))
    } else if ((!is.null(indice_select$i)) && (is.null(indice_select$j))) {
      return(value_df(df,i=indice_select$i,j=NULL))
    } else if ((is.null(indice_select$i)) && (!is.null(indice_select$j))) {
      return(value_df(df,i=NULL,j=indice_select$j))
    }
  } else {
    return(value_df(df,i=i,j=j))
  }
}

value_df <- function(df,i=NULL,j=NULL){
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
