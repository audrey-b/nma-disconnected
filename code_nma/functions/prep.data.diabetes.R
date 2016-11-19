prep.data.diabetes <- function(){
  
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
  
  plot.network(paste0(output.folder,"/plots/raw_data_network.pdf"), 
               diabetes, 
               "", 
               trt.names.data.frame)
  
  write.treatment.description(paste0(output.folder,"/treatment-description.txt"),
                              trt.names.data.frame,
                              ref.trt)
  
  return(list("data"=diabetes, "treatments"=trt.names.data.frame))
}
