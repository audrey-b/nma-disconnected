prep.data.diabetes.2arms <- function(){
  
  data(diabetes, package="pcnetmeta")
  
  #help(diabetes, package="pcnetmeta")
  
  trt.numbers <- order(unique(diabetes$t.id))
  
  trt.names <- c("Diuretic",
                 "Placebo",
                 "b-blocker",
                 "CCB",
                 "ACE inhibitor",
                 "ARB")
  
  trt.names.data.frame <- data.frame(cbind(trt.numbers, trt.names))
  
  n.arms <- table(diabetes$s.id)
  
  which.2.arms <- as.numeric(names(which(n.arms == 2)))
  
  diabetes.2.arms.only <- diabetes[which(diabetes$s.id %in% which.2.arms),]
  
  plot.network(paste0(output.folder,"/plots/2arms_network.pdf"), 
               diabetes.2.arms.only, 
               "", 
               trt.names.data.frame)
  
  write.treatment.description(paste0(output.folder,"/treatment-description.txt"),
                              trt.names.data.frame,
                              ref.trt)
  
  return(list("data"=diabetes.2.arms.only, "treatments"=trt.names.data.frame))
}
