
inv.mapping <- function(x,to,ref.trt=NA){
  if(!is.na(ref.trt)){
    if(x==1) return(ref.trt)
    else{
      ref.index <- which(to==ref.trt)
      return(to[-ref.index][x-1])
    }
  }
  else{
    return(to[x])
  }
  rm(list = ls())
}
