write.analysis.description <- function(file.name,
                                       description){
  
  sink(file.name)
  
  cat(
    date(),
    "\n\nDescription:", as.character(description),
    "\n\nSamples:", n.samples,
    "\nBurnin:", n.burnin,
    "\nThin:", thin,
    "\nAdapt:", n.adapt,
    "\nNumber of Chains:", n.chains)
  
  sink()
  rm(list = ls())
}