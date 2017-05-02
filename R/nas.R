
nas.col <- function(df){
  nas(df,2)
}

nas.row <- function(df){
  nas(df,1)
}

nas <- function(df,i){
  unique(unlist(apply(df,i,function(x) which(is.na(x)))))
}
