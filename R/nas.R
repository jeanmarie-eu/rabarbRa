
nas <- function(df,i){
  unique(unlist(apply(df,i,function(x) which(is.na(x)))))
}
