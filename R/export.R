export.json <- function(df, filename){
  if (!is.null(filename)) {
    write(jsonlite::toJSON(df),filename)
    invisible()
  } else return(jsonlite::toJSON(df))
}

export.rda <- function(df, filename){
  if (!is.null(filename)) {
    write(df,filename)
    invisible()
  } else return(df)
}

export.csv <- function(df, filename){
  if (!is.null(filename)) {
    write.csv(df,filename)
    invisible()
  } else return(df)
}
