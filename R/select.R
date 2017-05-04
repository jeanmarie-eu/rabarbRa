
select_ <- function(df,query){
  stopifnot(inherits(query,"queries"))
  if(length(query$q)==1){
    tmp <- lapply(query$q,select_one,df=df)
    i <- which(tmp[[1]])
    rm(tmp)
  } else if(length(query$q)>1){
    tmp <- lapply(query$q,select_one,df=df)
    i <- which(do.call(query$logic,args=list(tmp)))
    rm(tmp)
  } else stop("query object required")
  return(i)
}

select_one <-function(req,df){
  FUN <- get(q_fun_sign(req))
  res <- FUN(df[[q_field(req)]],q_value(req))
  return(res)
}

AND <- function(...){
  return(elogic("&&",...))
}

OR <- function(...){
  return(elogic("||",...))
}

elogic <- function(logic,...) {
  FUN <- function(...){
     return(mapply(logic, ...))
  }
  return(do.call("FUN",args=...))
}
