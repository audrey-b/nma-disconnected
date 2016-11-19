
extract.var.index <- function(var){
  index.with.bracket <- strsplit(var,"\\[")[[1]][2]
  return(as.numeric(substr(index.with.bracket,1,nchar(index.with.bracket)-1)))
  rm(list = ls())
}