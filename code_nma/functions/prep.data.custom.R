prep.data.custom <- function(){
  
  ### PG making stuff up here, Aug 26th
  dataset <- data.frame(
    s.id=rep(1:13,each=2),  
    t.id=c(rep(1:2,3),rep(2:3,3),rep(4:5,3),rep(5:6,3),3:4),
    n=100 + round(rnorm(26,20,5)),
    r=20 + round(rnorm(26,10,5)))
  
  
  trt.numbers <- order(unique(dataset$t.id))
  
  trt.names <- c("A", "B", "C", "D", "E","F")
  #Change to your own dataset
  #dataset <- data.frame(s.id=c(1,1,2,2,3,3,4,4,5,5), #Study id
   #                     t.id=c(1,2,1,3,1,4,3,4,2,4), #Treatment id
    #                    n=c(50,50,50,50,50,50,50,50,50,50), #Number of subjects
     #                   r=c(20,10,40,30,20,10,30,40,10,20)) #Outcome (binomial)

  #trt.numbers <- order(unique(dataset$t.id))
  
  #trt.names <- c("Placebo", #Change treatment names
   #              "Treatment 1",
    #             "Treatment 2",
     #            "Treatment 3")
  
  trt.names.data.frame <- data.frame(cbind(trt.numbers, trt.names))
  
  plot.network(paste0(output.folder,"/plots/raw_data_network.pdf"), 
               dataset, 
               "", 
               trt.names.data.frame)
  
  write.treatment.description(paste0(output.folder,"/treatment-description.txt"),
                              trt.names.data.frame,
                              ref.trt)
  
  return(list("data"=dataset, "treatments"=trt.names.data.frame))
}
