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

  object <- local({

    import <- function(df=NULL,filename=NULL){
      if (!is.null(filename)) {
        df_rab <<- jsonlite::fromJSON(filename)
      } else if (!is.null(df)){
        stopifnot(inherits(df,"data.frame"))
        df_rab <<- df
      } else df_rab <<- NULL
      invisible()
    }

    create <- function(names_array=NULL){
      if (is.null(df_rab)) {
        if (!is.null(names_array)) {
           df_rab <<- data.frame(matrix("NULL", 0, length(names_array),dimnames=list(c(), names_array)),stringsAsFactors=F)
        } else stop("Names of columns are needed")
      } else stop(" A listing is already existing. Create a new rabarbRa first.")
      invisible()
    }

    heads <- function(){
      return(head(df_rab,n=3L))
    }

    insert <- function(...){
      if (!is.null(df_rab)) {
        tmp <- data.frame(...,stringsAsFactors=F)
        stopifnot(inherits(tmp,"data.frame"))
        stopifnot(names(tmp)==names(df_rab))
        df_rab <<- rbind(df_rab,tmp)
      } else stop("Create a new listing first: new()")
      invisible()
    }

    delete <- function(query){
      indice <- select_(df=df_rab,query)
      df_rab <<- df_rab[-indice,]
      invisible()
    }

    select <- function(query) {
      return(select_(df=df_rab,query))
    }

    values <- function(query,field) {
      indice <- select_(df=df_rab,query)
      return(value(df=df_rab,indice=indice,field=field))
    }

    export <-function(filename=NULL,format="json"){
      switch(format,
        "json" = export.json(df=df_rab,filename=filename),
        "rda"  = export.rda(df=df_rab,filename=filename),
        stop("format not recognized: ", format))
    }

    #UPDATE
    #JOIN
    #GROUPBY: aggregate

    environment()
    })
    lockEnvironment(object, TRUE)
    structure(object, class=c("rabarbRa", class(object)))
}
