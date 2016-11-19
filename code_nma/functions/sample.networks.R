sample.networks <- function(data.tidied,
                            save.networks,
                            ref.trt,
                            n.disconnected.nodes,
                            max.samples){
  
  networks <- select.datasets(data=data.tidied$data, 
                              trt.names.data.frame=data.tidied$treatments, 
                              ref.trt=ref.trt, 
                              size=n.disconnected.nodes, 
                              max.samples= max.samples)
  
  networks$datasets <- c(networks$datasets, "Full-network"=list(data.tidied$data))
  
  if(save.networks==TRUE) save(networks, file=paste0(RData.folder,"/data.RData"))
  
  network.tables(datasets = networks$datasets)
  
  #networks$datasets[[1]]
  
  #dim(data.tidied$data)[1]
  
  #sapply(networks$datasets, nrow)
  #sapply(col.select.list(networks$datasets,"t.id"), function(x) length(unique(x)))
  #sapply(col.select.list(networks$datasets,"s.id"), function(x) length(unique(x)))
  #sapply(col.select.list(networks$datasets,"n"), sum)
  
  return(networks)
  
}