network.tables <- function(datasets){
  
  f <- function(dataset){
    by.t <- group_by(dataset,t.id)
    return(dplyr::summarize(by.t, tot.n = sum(n)))# tot.r = sum(r), tot.arms = length(r)))
  }
  tabl <- Reduce(function(x,y) merge(x,y,by="t.id",all=TRUE,suffixes=rnorm(2,0,1)), 
                 lapply(datasets, f), 
                 right=TRUE)
  colnames(tabl) <- c("t.id", names(datasets))
  write.csv(tabl, paste0(output.folder, "/totn.csv"), row.names = FALSE)
  
  f <- function(dataset){
    by.t <- group_by(dataset,t.id)
    return(dplyr::summarize(by.t, tot.arms = length(n)))# tot.r = sum(r), tot.arms = length(r)))
  }
  tabl <- Reduce(function(x,y) merge(x,y,by="t.id",all=TRUE,suffixes=rnorm(2,0,1)), 
                 lapply(datasets, f), 
                 right=TRUE)
  colnames(tabl) <- c("t.id", names(datasets))
  write.csv(tabl, paste0(output.folder, "/totarms.csv"), row.names = FALSE)
  
  f <- function(dataset){
    by.t <- group_by(dataset,t.id)
    return(dplyr::summarize(by.t, tot.arms = sum(r)))# tot.r = sum(r), tot.arms = length(r)))
  }
  tabl <- Reduce(function(x,y) merge(x,y,by="t.id",all=TRUE,suffixes=rnorm(2,0,1)), 
                 lapply(datasets, f), 
                 right=TRUE)
  colnames(tabl) <- c("t.id", names(datasets))
  write.csv(tabl, paste0(output.folder, "/totr.csv"), row.names = FALSE)
  
}