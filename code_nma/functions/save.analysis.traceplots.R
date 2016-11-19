
save.analysis.traceplots <- function(run.jags.object,
                                     description){
  png(paste0(output.folder,
             "/analysis/",
             description,
             "/traceplot",
             "-plot%02d.png"))
  traceplot(as.mcmc.list(run.jags.object))
  graphics.off()
  rm(list = ls())
}