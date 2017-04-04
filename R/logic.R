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
