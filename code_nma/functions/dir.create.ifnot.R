dir.create.ifnot <- function(directory){
  if(!dir.exists(directory)) dir.create(directory)
  rm(list = ls())
}