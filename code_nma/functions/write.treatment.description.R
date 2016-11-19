write.treatment.description <- function(file.name,
                                        trt.names.data.frame,
                                        ref.trt){
  
  sink(file.name)
  
  cat(
    date(),
    "\n\nTreatments:\n\n")
  
  print(trt.names.data.frame,row.names = FALSE)
  
  cat("\nThe reference treatment is:",ref.trt)
  
  sink()
  rm(list = ls())
}