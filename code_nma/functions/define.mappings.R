define.mappings <- function(id.frame, ref.trt.list){
  
  res <- lapply(names(ref.trt.list), function(i)
    define.mapping((unique(id.frame[,i])),
                   ref.trt.list[[i]])
  )
  
  names(res) <- names(ref.trt.list)
  
  return(res)
  rm(list = ls())
}