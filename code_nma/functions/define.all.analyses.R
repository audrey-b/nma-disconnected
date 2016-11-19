define.all.analyses <- function(dataset.names, model.files){
  
  which.analyses <- data.frame(cbind(dataset.names, 
                                     model.files), 
                               stringsAsFactors=FALSE)
  #expand.grid(dataset.names,
  #           model.files, 
  #          stringsAsFactors = FALSE)
  
  description <- paste0(
    as.character(which.analyses[,1]),
    "-",
    strsplit(as.character(which.analyses[,2]),".bug"))
  
  which.analyses <- cbind(which.analyses, description)
  
  names(which.analyses) <- c("Data", "Model", "Description")
  
  for(i in 1:dim(which.analyses)[1]){
    dir.create.ifnot(paste0(output.folder,"/analysis/",which.analyses$Description[i]))
    dir.create.ifnot(paste0(RData.folder,"/",which.analyses$Description[i]))
  }
  
  return(which.analyses)
  rm(list = ls())
}