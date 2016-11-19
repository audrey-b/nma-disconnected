unmap.names <- function(vars,
                        mapping.table,
                        var.equiv.table){
  
  
  constrast.id <- grep(" vs ", vars)
  new.vars <- vars
  var.name <- sapply(vars, extract.var.name)
  var.index.nocontrast <- rep(NA, length(new.vars))
  var.index.contrast1 <- rep(NA, length(new.vars))
  var.index.contrast2 <- rep(NA, length(new.vars))
  var.index.nocontrast[-constrast.id] <- sapply(vars[-constrast.id], extract.var.index)
  var.index.contrast1[constrast.id] <- sapply(unlist(strsplit(vars[constrast.id], " "))
                                              [seq(1,3*length(vars[constrast.id]),3)]
                                              , extract.var.index)
  var.index.contrast2[constrast.id] <- sapply(unlist(strsplit(vars[constrast.id], " "))
                                              [seq(3,3*length(vars[constrast.id]),3)]
                                              , extract.var.index)
  
  for(i in 1:length(mapping.table)){
    
    var.index.nocontrast.unmapped <- rep(NA, length(new.vars))
    var.index.contrast1.unmapped <- rep(NA, length(new.vars))
    var.index.contrast2.unmapped <- rep(NA, length(new.vars))
    
    var.equiv.table.index <- which(rownames(var.equiv.table) == names(mapping.table)[i])
    
    which.var <- which(var.name %in% as.character(var.equiv.table$Vars.monitored[var.equiv.table.index]))   
    
    
    if(is.na(var.equiv.table$Reference[var.equiv.table.index])){
      var.index.nocontrast.unmapped[which.var] <- mapvalues(var.index.nocontrast[which.var], mapping.table[[i]]$to, mapping.table[[i]]$from, warn_missing = TRUE)
      
      new.vars[which.var] <- paste0(var.name[which.var],
                                    "_",
                                    var.index.nocontrast.unmapped[which.var])
    } else{
      remove <- which(mapping.table[[i]]$to==1)
      var.index.nocontrast.unmapped[which.var] <- mapvalues(var.index.nocontrast[which.var]+1, mapping.table[[i]]$to[-remove], mapping.table[[i]]$from[-remove], warn_missing = TRUE)
      var.index.contrast1.unmapped[which.var] <- mapvalues(var.index.contrast1[which.var]+1, mapping.table[[i]]$to[-remove], mapping.table[[i]]$from[-remove], warn_missing = FALSE)
      var.index.contrast2.unmapped[which.var] <- mapvalues(var.index.contrast2[which.var]+1, mapping.table[[i]]$to[-remove], mapping.table[[i]]$from[-remove], warn_missing = FALSE)
      
      new.vars[setdiff(which.var,constrast.id)] <- paste0(var.name[setdiff(which.var,constrast.id)],
                                                          "_",
                                                          var.equiv.table$Reference[var.equiv.table.index],
                                                          ",",
                                                          var.index.nocontrast.unmapped[setdiff(which.var,constrast.id)])
      
      new.vars[intersect(which.var,constrast.id)] <- paste0(var.name[intersect(which.var,constrast.id)],
                                                            "_",
                                                            var.equiv.table$Reference[var.equiv.table.index],
                                                            ",",
                                                            var.index.contrast1.unmapped[intersect(which.var,constrast.id)],
                                                            " - ",
                                                            var.name[intersect(which.var,constrast.id)],
                                                            "_",
                                                            var.equiv.table$Reference[var.equiv.table.index],
                                                            ",",
                                                            var.index.contrast2.unmapped[intersect(which.var,constrast.id)])
    }
  }
  
  return(new.vars)
  rm(list = ls())
}

