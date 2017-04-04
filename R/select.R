
select_ <- function(df,query){
  stopifnot(inherits(query,"queries"))
  if(length(query$q)==1){
    tmp <- lapply(query$q,select_one,df=df)
    res <- which(tmp[[1]])
    rm(tmp)
  } else if(length(query$q)>1){
    tmp <- lapply(query$q,select_one,df=df)
    res <- which(do.call(query$logic,args=list(tmp)))
    rm(tmp)
  } else stop("query object required")
  return(res)
}

select_one <-function(req,df){
  FUN <- get(req$fun_sign)
  res <- FUN(df[[req$field]],req$value)
  return(res)
}
