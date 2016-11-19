metric.table <- function(which.compare.list, 
                         summaries.list, 
                         select, 
                         revert.mapping){
  
  metric <- function(lower, upper, mcmc){
    mean(mcmc >= lower & mcmc <= upper)
  }
  
  if(revert.mapping==TRUE){
    load(file=paste0(RData.folder,"/mapping.RData")) #mappingtables
  }
  
  result <- data.frame(measure=numeric(),description=character(),variable=character())
  
  for(i in 1:length(which.compare.list)){
    baseline.description <- which.compare.list[[i]][which(which.compare.list[[i]][,"Reference case for comparison"]=="YES"),"Description"]
    baseline <- which(which.analyses["Description"]==baseline.description)
    vs.description <- which.compare.list[[i]][which(which.compare.list[[i]][,"Reference case for comparison"]=="NO"),"Description"]
    vs <- which(which.analyses["Description"]==vs.description)
    load(paste0(RData.folder,"/", baseline.description, "/mcmc_unmapped.RData")) #run.jags.result

    for(j in row.names(summaries.list[[vs.description]])){
      measure <- metric(summaries.list[[vs.description]][j,]$Lower95,
                        summaries.list[[vs.description]][j,]$Upper95,
                        do.call(rbind, run.jags.result.unmapped)[,j] )
      description <- as.character(vs.description)
      var <- j
      result <- rbind(result, data.frame(measure, description , var))
    }
    rm(run.jags.result.unmapped)
    gc()
  }
  
  h = hist(result$measure[grep("d", result$var)], breaks=seq(0,1,0.05))
  h$density = h$counts/sum(h$counts)*100
  pdf(paste0(output.folder,"/analysis/histogram.pdf"))
  plot(h,
       freq=FALSE,
       main="",
       xlab="Statistical Distance",
       ylab="Percentage",
       xlim=c(0,1),
       ylim=c(0,100)
  )
  graphics.off()
  
  bins <- pasteCols(rbind(h$breaks[-length(h$breaks)],",",h$breaks[-1],"]"))
  bins[1] <- paste0("[",bins[1])
  bins[-1] <- paste0("(",bins[-1])
  freq.table <- data.frame(bins, h$counts, h$density)
  colnames(freq.table) <- c("Value", "Count", "%")
  
  write.csv(freq.table, paste0(output.folder,"/analysis/table.csv" ), row.names = FALSE)
  
  result.cast <- dcast(melt(result, id.vars = c("var","description")), var ~  description)
  result.cast <- result.cast[match(row.names(summaries.list[[baseline]]), result.cast$var),]
  result.cast$var <- row.names(summaries.list[[baseline]])
  
  write.csv(result.cast, paste0(output.folder,"/analysis/results.csv" ), row.names = FALSE)
  
}