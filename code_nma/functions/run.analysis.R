run.analysis <- function(dataset.to.analyze, 
                         data.name,
                         model.file, 
                         description,
                         mapping.table,
                         save.mcmcs,
                         traceplots){
  
  
  NUMAGENTS <- length(unique(dataset.to.analyze$t.id))
  NUMTRIALS <- length(unique(dataset.to.analyze$s.id))
  TOTARMS <- dim(dataset.to.analyze)[1]
  
  data.jags <- list(y=dataset.to.analyze$r,
                    trial=dataset.to.analyze$s.id.mapped,
                    agent=dataset.to.analyze$t.id.mapped,
                    n=dataset.to.analyze$n,
                    NUMAGENTS=NUMAGENTS,
                    NUMTRIALS=NUMTRIALS,
                    TOTARMS=TOTARMS)
  
  #inits.jags <- list(sig2=runif(1,0,10),
  #                  d=rnorm(NUMAGENTS-1,0,10),
  #                 alpha=rnorm(NUMTRIALS,0,5))
  inits.jags <- function() {
    return(list(sig2=runif(1,0,6), 
                d=rnorm(NUMAGENTS-1,0,4), 
                alpha=rnorm(NUMTRIALS,0,4)))
  }
  
  
  run.jags.result <- run.jags(model=paste0("code_nma/models/", model.file), 
                              monitor=vars.monitor,
                              data=data.jags, 
                              n.chains=n.chains, 
                              method="rjags", 
                              inits=inits.jags, 
                              sample=n.samples, 
                              adapt=n.adapt, 
                              thin=thin, 
                              burnin=n.burnin, 
                              summarise=FALSE, 
                              keep.jags.files = FALSE,
                              mutate=list(contrasts.mcmc,"d") )
  
  write.analysis.description(paste0(output.folder,
                                    "/analysis/",
                                    description,
                                    "/analysis-description.txt"), 
                             description)
  
  if(save.mcmcs==TRUE){
    save(run.jags.result, file=paste0(RData.folder,
                                      "/"
                                      ,description,
                                      "/mcmc.RData"))
    
  }
  
  
  #Save traceplots
  if(traceplots==TRUE){
    save.analysis.traceplots(as.mcmc.list(run.jags.result), 
                             description)
  }
  
  
  rm(run.jags.result)
  gc()
  
  rm(list = ls())
  
}