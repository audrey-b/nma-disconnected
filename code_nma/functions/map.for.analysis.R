map.for.analysis <- function(data, mappings){
  
  for(l in 1:length(data)){
    
    var.names <- names(mappings[[l]])
    new.var.names <- paste0(var.names,".mapped")
    
    for(i in 1:lapply(mappings, length)[[l]]){
      
      new.col <- mapvalues(get(var.names[i],data[[l]]), 
                           mappings[[l]][[i]]$from, 
                           mappings[[l]][[i]]$to)
      
      
      data[[l]] <- cbind(data[[l]], new.col)
      colnames(data[[l]])[which(colnames(data[[l]]) == "new.col")] <- new.var.names[i]
    }
  }
  
  return(data)
  rm(list = ls())
}



