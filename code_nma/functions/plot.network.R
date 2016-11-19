plot.network <- function(file.name, 
                         data, 
                         title, 
                         trt.names.data.frame){
  pdf(file.name)
  nma.networkplot(s.id, 
                  t.id, 
                  data = data, 
                  title = title,
                  trtname = trt.names.data.frame[which( 
                    trt.names.data.frame$trt.numbers %in%
                      unique(data$t.id) ), "trt.names"])
  graphics.off() 
  
  
  rm(list = ls())
}