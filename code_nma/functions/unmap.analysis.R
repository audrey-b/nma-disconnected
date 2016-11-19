unmap.analysis <- function(run.jags.object, 
                           vect.names.data.bug.file, 
                           mapping.table,
                           var.equiv.table){
  
  mcmc.chain <- as.mcmc(run.jags.object) #Using only the first chain to draw the posterior
  
  new.names <- unmap.names(colnames(mcmc.chain), mapping.table, var.equiv.table)
  
  mcmc.chain <- data.frame(mcmc.chain)
  
  #Add a column to describe the method
  
  method <- rep(paste(vect.names.data.bug.file,collapse="-"), 
                dim(mcmc.chain)[1])
  
  mcmc.chain <- cbind(method, mcmc.chain)
  
  colnames(mcmc.chain) <- c("Method", new.names)
  new.names <- c("Method", new.names)
  
  contrast.id <- grep(" - ", colnames(mcmc.chain))
  
  contrast1 <- unlist(strsplit(new.names[contrast.id], " "))[seq(1,3*length(new.names[contrast.id]),3)]
  contrast2 <- unlist(strsplit(new.names[contrast.id], " "))[seq(3,3*length(new.names[contrast.id]),3)]
  
  contrast.ok <- contrast1 < contrast2
  
  if(!all(contrast.ok)){
    mcmc.chain[,contrast.id[!contrast.ok]] <- -mcmc.chain[,contrast.id[!contrast.ok]]
    colnames(mcmc.chain)[contrast.id[!contrast.ok]] <- paste0(contrast2, " - ", contrast1)[!contrast.ok]
  }
  return(mcmc.chain)
  rm(list = ls())
}