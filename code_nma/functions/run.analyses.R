
run.analyses <- function(networks,
                         which.analyses,
                         inputs,
                         use.mapping,
                         save.mcmcs,
                         traceplots){
  
  runjags.options("force.summary"=TRUE)
  
  
  
  if(!is.null(inputs) && !is.na(inputs)){
    for(i in 1:length(inputs)){
      source(paste0("code_nma/inputs/", inputs[i]), 
             local=FALSE, 
             chdir=TRUE)
    }
  }
  
  if(use.mapping==TRUE){
    
    ###Assign new treatment and study ids,###
    ###using consecutive numbers starting with one,###
    ###so the data can be processed in JAGS###
    #cat("\nTreatment and trials are being renumbered for analysis. Proper unmapping
    #   of the monitored parameters relies on proper classification given in
    #   var.equiv.table provided as input by the user.\n")
    mapping.tables <- lapply(col.select.list(networks$datasets, c("t.id","s.id")),
                             define.mappings,
                             ref.trt.list=list("t.id"=ref.trt,"s.id"=NA))
    save(mapping.tables, file=paste0(RData.folder,"/mapping.RData"))
    data.list <- map.for.analysis(networks$datasets, mapping.tables)
  } else{
    data.list <- networks$datasets
  }
  
  
  for(i in 1:dim(which.analyses)[1]){
    cat(paste0("\nAnalyzing ", which.analyses$Description[i], "\n"))
    run.analysis(dataset.to.analyze=data.list[[which.analyses$Data[i]]],
                 data.name=which.analyses$Data[i],
                 model.file=which.analyses$Model[i],
                 description=which.analyses$Description[i],
                 mapping.table=mapping.tables[i],
                 save.mcmcs=save.mcmcs,
                 traceplots=traceplots)
  }
  
  if(save.mcmcs==TRUE){
    cat("\nMCMC chains were saved in",paste0("/",RData.folder,"/"),"\n")
  }
  if(traceplots==TRUE){
    cat("\nTraceplots were saved in",paste0("/",output.folder,"/analysis/"),"\n")
  }
  
  
}
