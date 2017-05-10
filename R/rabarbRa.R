#' rabarbRa
#'
#' rabarbRa
#' @param df data.frame
#' @param filename filename
#' @param url url
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' rabarbRa()
#' }
rabarbRa <- function(df=NULL,filename=NULL,url=NULL){

  rabarbRa_object(df=df,filename=filename,url=url)
}

rabarbRa_object <- function(df,filename,url){

  df_rab <- NULL
  if (!is.null(df)) {
    df_rab <- df
  } else if ( !is.null(filename) || !is.null(url) ){
    df_rab <- import_(filename=filename,url=url)
  } else stop("need arguments. ")

  indice_select <- list(i=NULL,j=NULL)

  object <- local({

    ##########
    # Basics #
    ##########

    export <-function(filename=NULL,format="json"){
      switch(format,
        "json" = export.json(df=df_rab,filename=filename),
        "csv"  = export.csv(df=df_rab,filename=filename),
        "rda"  = export.rda(df=df_rab,filename=filename),
        stop("format not recognized: ", format))
    }

    summary <- function(){
        return(
          list(colname = names(df_rab),
               dim     = dim(df_rab)))
    }


    #######################
    # Values Manipulation #
    #######################
    indice <- function(i=NULL,j=NULL){
      if (!is.null(i)) indice_select$i <<-i
      if (!is.null(j)) indice_select$j <<-j
      invisible()
    }

    getindice <- function() {
      return(indice_select)
    }

    select <- function(subset,variable) {
      indice_select <<- select_(df=df_rab,subset,variable)
      invisible()
    }

    values <- function(i=NULL,j=NULL) {
      on.exit(indice_select <<- list(i=NULL,j=NULL))
      return(value_(df_rab,indice_select=indice_select,i=i,j=j))
	  }

    modify <- function(i=NULL,j=NULL,value) {
      if ( (!is.null(indice_select$i)) || (!is.null(indice_select$j)) ) {
        modify_(df=df_rab,i=indice_select$i,j=indice_select$j) <- value
      } else {
        modify_(df=df_rab,i=i,j=j) <- value
      }
      df_rab <<-df_rab
      on.exit(indice_select <<- list(i=NULL,j=NULL))
      invisible()
    }


    ################
    # Evaluation   #
    ################

    expression <- function(...){
      on.exit(indice_select <<- list(i=NULL,j=NULL))
      return(eval_expr(df=value_(df_rab,indice_select=indice_select),...))
    }

    process <- function(FUN,...){
      on.exit(indice_select <<- list(i=NULL,j=NULL))
      return(FUN(value_(df_rab,indice_select=indice_select),...))
    }

    na <- function(dim){
      return(nas(df=value_(df_rab,indice_select=indice_select),dim))
    }

    environment()
    })
    lockEnvironment(object, TRUE)
    structure(object, class=c("rabarbRa", class(object)))
}
