uniformize.contrast.order <- function(mcmc.chain){
  
   contrast.id <- grep(" - ", colnames(mcmc.chain))
   contrast1 <- unlist(strsplit(colnames(mcmc.chain)[contrast.id], " "))[seq(1,
                                                                                3*length(colnames(mcmc.chain)[contrast.id]),
                                                                                3)]
   contrast2 <- unlist(strsplit(colnames(mcmc.chain)[contrast.id], " "))[seq(3,
                                                                                3*length(colnames(mcmc.chain)[contrast.id]),
                                                                                3)]
   contrast.ok <- contrast1 < contrast2
   if(!all(contrast.ok)){
     mcmc.chain[,contrast.id[!contrast.ok]] <- -mcmc.chain[,contrast.id[!contrast.ok]]
     colnames(mcmc.chain)[contrast.id[!contrast.ok]] <- paste0(contrast2, " - ", contrast1)[!contrast.ok]
   } 
   
   return(mcmc.chain)
  
}