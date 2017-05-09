###############################################
# eval_expr function intern to a rabarbRa object #
###############################################
# This is a simple first version.
# This has been built to get a first algorithm architecture
# The process/algorithm/code language might be adapted soon.
# Objectives: low RAM, fast computing

eval_expr <- function(df,expr){
  x <- as.lazy(expr)
  return(eval(x$expr,df))
}
