posterior.plot <- function(description, 
                           file.name){
  
  chains <- list()
  for(l in 1:length(description)){
    load(paste0(RData.folder,"/",description[l],"/mcmc_unmapped.RData"))
    chains[[l]] <- data.frame(do.call(rbind,run.jags.result.unmapped), row.names = NULL)
    chains[[l]]$Method <- description[l]
    colnames(chains[[l]]) <- c(colnames(do.call(rbind,run.jags.result.unmapped)),"Method")
    rm(run.jags.result.unmapped)
  }
  
  chains.vars <- lapply(chains, colnames)
  all.vars <- unique(unlist(chains.vars)) 
  all.vars <- all.vars[-length(all.vars)] #Removing method
  
  pdf(file.name, onefile = TRUE)
  
  for(var in all.vars){
    
    which.applies <- which(is.na(lapply(chains.vars, match, x=var))==FALSE) #which datasets contain the variable
    vars.unlisted <- unlist(col.select.list(chains[which.applies], var))
    methods.unlisted <- unlist(col.select.list(chains[which.applies], "Method"))
    dataframe.results <- data.frame(methods.unlisted, vars.unlisted)
    names(dataframe.results) <- c("Method",var)
    data.to.plot <- dataframe.results
    
    all.methods <- data.frame(as.character(unique(dataframe.results$Method)))
    method.linetypes <- cbind(all.methods,1:dim(all.methods)[1])
    names(method.linetypes) <- c("Method","Linetype")
    
    methods.to.plot <- unique(data.to.plot$Method)
    linetypes.to.plot <- method.linetypes[which(method.linetypes$Method %in% methods.to.plot),]$Linetype
    
    plot.object <- ggplot(data.to.plot, aes(x=get(var))) + 
      geom_density(aes(group=Method, linetype=Method)) +
      xlab(var) +
      ylab("Density") +
      scale_linetype_manual(values=linetypes.to.plot)
    
    print(plot.object)
  }
  graphics.off()
  rm(list = ls())
}