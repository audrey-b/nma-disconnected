unmap.analyses <- function(run.jags.chains.list, 
                           which.analyses, 
                           mapping.tables, 
                           var.equiv.table){
  
  return(lapply(1:length(run.jags.chains.list), function(i) unmap.analysis(run.jags.chains.list[[i]], 
                                                                           which.analyses[i,-3], 
                                                                           get(which.analyses$Data[i], mapping.tables),
                                                                           var.equiv.table)))
  rm(list = ls())
}