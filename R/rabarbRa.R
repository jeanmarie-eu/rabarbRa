#' rabarbRa
#'
#' rabarbRa
#' @keywords rabarbRa
#' @export
#' @examples
#' \dontrun{
#' rabarbRa()
#' }
rabarbRa <- function(){
  #let possibilities for connections options, handles, ...
  rabarbRa_object()
}

rabarbRa_object <- function(){

  df_rab <- NULL
  indice_select <- list(i=NULL,j=NULL)

  object <- local({

    ##########
    # Basics #
    ##########

    import <- function(df=NULL,filename=NULL,url=NULL){
      if (!is.null(df)) {
        df_rab <<- df
      } else if ( !is.null(filename) || !is.null(url) ){
        df_rab <<- import_(filename=filename,url=url)
      } else stop("need arguments. ")
      invisible()
    }

    export <-function(filename=NULL,format="json"){
      switch(format,
        "json" = export.json(df=df_rab,filename=filename),
        "csv"  = export.csv(df=df_rab,filename=filename),
        "rda"  = export.rda(df=df_rab,filename=filename),
        stop("format not recognized: ", format))
    }

    summary <- function(){
        return(list(colname = names(df_rab),
                     dim = dim(df_rab)))
    }


    #######################
    # Values Manipulation #
    #######################

    select <- function(query=NULL,variable=NULL) {
      if (!is.null(query)){
         indice_select$i <<- select_row_(df=df_rab,query)
      }
      if (!is.null(variable)){
         indice_select$j <<- select_var_(df_rab,variable)
      }
      if (identical(indice_select$i,integer(0)) ) {
        indice_select$i <<- NULL
        message("query provided integer(0), kept to NULL")
      }
      if (identical(indice_select$j,integer(0)) ) {
        indice_select$j <<- NULL
        message("variables provided integer(0), kept to NULL")
      }
      invisible()
    }

    getselect <- function() {
      return(indice_select)
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
