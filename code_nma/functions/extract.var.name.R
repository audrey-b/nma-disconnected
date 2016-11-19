
extract.var.name <- function(var){
  return(strsplit(var,"\\[")[[1]][1])
  rm(list = ls())
}