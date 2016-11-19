define.mapping <- function(id, ref.trt){
  
  id.mapped <- sapply(id,
                      mapping,
                      from=unique(id),
                      ref.trt=ref.trt)
  
  mapping.table <- unique(data.frame(cbind(id, id.mapped)))
  colnames(mapping.table) <- c("from","to")
  mapping.table <- mapping.table[order(mapping.table$from),]
  
  return(mapping.table)
  rm(list = ls())
}