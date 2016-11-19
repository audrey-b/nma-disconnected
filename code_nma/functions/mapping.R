

mapping <- function(x, from, ref.trt=NA){
  if(!is.na(ref.trt)){
    if(x==ref.trt) return(1)
    else{
      ref.index <- which(from==ref.trt)
      index <- which(from[-ref.index]==x)+1
      return(index)
    }
  }
  else{
    index <- which(from==x)
    return(index)
  }
  rm(list = ls())
}