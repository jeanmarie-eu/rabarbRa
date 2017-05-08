
###############################################
# import_ function intern to a rabarbRa object #
###############################################
# This is a simple first version.
# This has been built to get a first algorithm architecture
# The process/algorithm/code language might be adapted soon.
# Objectives: low RAM, fast computing

import_ <- function(filename=NULL,url=NULL){
  if (!is.null(filename) && is.null(url) ) {
    target <- paste0("file://",filename)
  } else if (is.null(filename) && !is.null(url) ) {
    target <- url
  } else stop("Both filename and url are non-NULL")
  return(import_target(target))
}

import_target <- function(target){
  ext <- tools::file_ext(target)
  res <- switch(ext,
    "json" = jsonlite::fromJSON(curl::curl(target)),
    "csv"  = read.csv(curl::curl(target),header=TRUE),
    stop("extension not recognized: ", ext))
  return(res)
}
