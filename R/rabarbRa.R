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
  #let possibilities for connections
  rabarbRa_object()
}

rabarbRa_object <- function(){

  df_rab <- NULL
  indice_select <- list(i=NULL,j=NULL)

  object <- local({

    ##########
    # Basics #
    ##########

    import <- function(df=NULL,filename=NULL){
      if (!is.null(filename)) {
        ext <- tools::file_ext(filename)
        df_rab <<- switch(ext,
          "json" = jsonlite::fromJSON(filename),
          "csv"  = read.csv(filename,header=TRUE),
          stop("extension not recognized: ", ext))
      } else if (!is.null(df)){
        stopifnot(inherits(df,"data.frame"))
        df_rab <<- df
      } else df_rab <<- NULL
      invisible()
    }

    export <-function(filename=NULL,format="json"){
      switch(format,
        "json" = export.json(df=df_rab,filename=filename),
        "csv"  = export.csv(df=df_rab,filename=filename),
        "rda"  = export.rda(df=df_rab,filename=filename),
        stop("format not recognized: ", format))
    }

    create <- function(names_array=NULL){
      if (is.null(df_rab)) {
        if (!is.null(names_array)) {
           df_rab <<- data.frame(matrix("NULL", 0, length(names_array),dimnames=list(c(), names_array)),stringsAsFactors=F)
        } else stop("Names of columns are needed")
      } else stop(" A listing is already existing. Create a new rabarbRa first.")
      invisible()
    }

    insert <- function(...){
      if (!is.null(df_rab)) {
        tmp <- data.frame(...,stringsAsFactors=F)
        stopifnot(inherits(tmp,"data.frame"))
        stopifnot(names(tmp)==names(df_rab))
        df_rab <<- rbind(df_rab,tmp)
      } else stop("Create a new listing first: $create()")
      invisible()
    }

    summary <- function(){
        return(list(colname = colnames(df_rab),
                     dim = dim(df_rab)))
    }


    ################
    # Manipulation #
    ################

    select <- function(query=NULL,field=NULL) {
      if (!is.null(query)){
         indice_select$i <<- select_(df=df_rab,query)
      }
      if (!is.null(field)){
         indice_select$j <<- which((names(df_rab) == field))
      }
      if (identical(indice_select$i,integer(0)) ) {
        indice_select$i <<- NULL
        message("query provided integer(0), kept to NULL")
      }
      if (identical(indice_select$j,integer(0)) ) {
        indice_select$j <<- NULL
        message("fields provided integer(0), kept to NULL")
      }
      invisible()
    }

    delete <- function(i=NULL,j=NULL){
      if ( (!is.null(indice_select$i)) || (!is.null(indice_select$j)) ) {
        delete_(df_rab,i=indice_select$i,j=indice_select$i)
      } else delete_(df_rab,i=i,j=j)
      on.exit(indice_select <<- list(i=NULL,j=NULL))
      invisible()
    }

    values <- function(i=NULL,j=NULL) {
      if ( (!is.null(indice_select$i)) || (!is.null(indice_select$j)) ) {
        on.exit(indice_select <<- list(i=NULL,j=NULL))
        return(value_(df_rab,i=indice_select$i,j=indice_select$i))
      } else {
        on.exit(indice_select <<- list(i=NULL,j=NULL))
        return(value_(df_rab,i=i,j=j))
      }

    }

    modify <- function(i=NULL,j=NULL,value) {
      if ( (!is.null(indice_select$i)) || (!is.null(indice_select$j)) ) {
        modify_(df=df_rab,i=indice_select$i,j=indice_select$j) <- value
        df_rab <<-df_rab
      } else {
        modify_(df=df_rab,i=i,j=j) <- value
        df_rab <<-df_rab
      }
      on.exit(indice_select <<- list(i=NULL,j=NULL))
      invisible()
    }


    ################
    # Evaluation   #
    ################

    expression <- function(...){
       return(eval_expr(df=df_rab,...))
    }

    process <- function(FUN,...){
      return(FUN(df_rab,...))
    }

    na <- function(dim){
      return(nas(df=df_rab,dim))
    }

    environment()
    })
    lockEnvironment(object, TRUE)
    structure(object, class=c("rabarbRa", class(object)))
}
