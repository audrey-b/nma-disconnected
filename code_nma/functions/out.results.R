
out.results <- function(inputs,
                        which.analyses,
                        which.compare.list,
                        revert.mapping,
                        metrics,
                        posteriors){
  
  runjags.options("force.summary"=TRUE)
  
  if(!is.null(inputs) && !is.na(inputs)){
    for(i in 1:length(inputs)){
      source(paste0("code_nma/inputs/", inputs[i]), 
             local=FALSE, 
             chdir=TRUE)
    }
  }
  
  

  #Compute summaries
  unique.descrip <-c()
  for(i in 1:length(which.compare.list)){
    unique.descrip <- c(unique.descrip,which.compare.list[i][[1]][,"Description"])
  }
  unique.descrip <- unique(unique.descrip)
  
  which.analyses.subset <- which.analyses[which(which.analyses$Description %in% unique.descrip),]
  
  summaries.list <- list()
  if(revert.mapping==TRUE){
    load(file=paste0(RData.folder,"/mapping.RData")) #mappingtables
  }
  for(j in 1:dim(which.analyses.subset)[1]){
    load(paste0(RData.folder,"/", as.character(which.analyses.subset[j,]$Description),"/mcmc.RData"))
    run.jags.result.unmapped <- as.mcmc.list(run.jags.result)#, vars = c("d"), add.mutate = TRUE)
    if(revert.mapping==TRUE){ 
      for(i in 1:n.chains){
        colnames(run.jags.result.unmapped[[i]]) <- unmap.names(vars= colnames(run.jags.result.unmapped[[i]]),
                                                               mapping.table = mapping.tables[which.analyses.subset[j,"Data"]][[1]], 
                                                               var.equiv.table = var.equiv.table)
      }
    }
    run.jags.result.unmapped <- as.mcmc.list(lapply(run.jags.result.unmapped, uniformize.contrast.order))
    summaries.list[[j]] <- summary.analysis(run.jags.result.unmapped)
    #mcmc.unmapped <- do.call(rbind, run.jags.result.unmapped)
    save(run.jags.result.unmapped, file=paste0(RData.folder,"/",as.character(which.analyses.subset[j,]$Description),"/mcmc_unmapped.RData"))
    rm(run.jags.result.unmapped)
    gc()
    
  }
  
  names(summaries.list) <- as.character(which.analyses.subset$Description)

  #save(summaries.list, file=paste0(RData.folder,"/summaries.RData"))
  
  if(metrics==TRUE){
    metric.table(which.compare.list, 
                 summaries.list, 
                 networks,
                 revert.mapping = revert.mapping)
    cat("\nDelta values were saved in",paste0("/",output.folder,"/analysis/"),"\n")
  }

  if(posteriors==TRUE){
    for(i in 1:length(which.compare.list)){
      posterior.plot(description=which.compare.list[[i]][,"Description"],
                     file.name=paste0(output.folder,"/analysis/posteriors-",i,".pdf"))
    }
    cat("\nPosterior plots were saved in",paste0("/",output.folder,"/analysis/"),"\n")
  }
  
  
}
