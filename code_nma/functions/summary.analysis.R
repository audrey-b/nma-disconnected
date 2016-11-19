summary.analysis <- function(result.mcmc.list){

  
  summ <- summary(result.mcmc.list)
  summary.stats <- data.frame(cbind(summ$statistics[,c("Mean","SD")],summ$quantiles[,c("2.5%","50%","97.5%")]))

  
  names(summary.stats) <- c("Mean", "SD", "Lower95", "Median", "Upper95")
  # 
  # #Improve the presentation of the contrasts
  # contrast.id <- grep(" - ", rownames(summary.stats))
  # contrast1 <- unlist(strsplit(rownames(summary.stats)[contrast.id], " "))[seq(1,
  #                                                                              3*length(rownames(summary.stats)[contrast.id]),
  #                                                                              3)]
  # contrast2 <- unlist(strsplit(rownames(summary.stats)[contrast.id], " "))[seq(3,
  #                                                                              3*length(rownames(summary.stats)[contrast.id]),
  #                                                                              3)]
  # contrast.ok <- contrast1 < contrast2
  # if(!all(contrast.ok)){
  #   summary.stats[contrast.id[!contrast.ok],] <- -summary.stats[contrast.id[!contrast.ok],]
  #   rownames(summary.stats)[contrast.id[!contrast.ok]] <- paste0(contrast2, " - ", contrast1)[!contrast.ok]
  # }
  
  return(summary.stats) 
  rm(list = ls())
}