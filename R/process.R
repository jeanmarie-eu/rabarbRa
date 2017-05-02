connect_column <- function(df,...){
  args <- list()
  vname <- c(...)
  if (length(vname)) {
    lapply(vname,function(x){
         args <<- cbind(args,list(df[,x]))
         invisible()
    } )
    names(args)<-vname
    return(args)
  } else{invisible()}
}

eval_expr <- function(df,expr){
  x <- as.lazy(expr)
  return(eval(x$expr,df))
}
