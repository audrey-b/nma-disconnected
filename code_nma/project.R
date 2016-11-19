rm(list = ls())

###Get inputs and header###
source(paste0("code_nma/inputs/inputs.general.R"), 
       local=FALSE, 
       chdir=TRUE)
input.variables <- ls()

source("code_nma/header.R", 
       local=FALSE, 
       chdir=TRUE)

###Start writing output to file###
sink(paste0(output.folder,"/Routput.txt"), append=FALSE, split=TRUE) 
cat(date(),"\n\nInputs provided by the user:\n")
sapply(input.variables,get)

###Get tidied data###
data.tidied <- get(data.fct.name)()
cat("\nFull network data\n")
data.tidied

###Simulate networks###
networks <- sample.networks(data.tidied = data.tidied,
                            save.networks = TRUE,
                            ref.trt = ref.trt,
                            n.disconnected.nodes = n.disconnected.nodes,
                            max.samples = max.samples)

cat("\nNames of the networks available for the analyses\n")
names(networks$datasets)

###Select which analyses will be performed###
which.analyses <- define.all.analyses(names(networks$datasets), 
                                      c(rep("model-random.bug", 
                                            length(networks$datasets)-1), 
                                        "model-fixed.bug"))
cat("\nAnalyses to be conducted:\n")
which.analyses

save(which.analyses, file=paste0(RData.folder,"/whichanalyses.RData"))


###Run analyses###
run.analyses(networks,
             which.analyses,
             inputs="inputs.general.R",
             use.mapping=mapping.needed,
             save.mcmcs=TRUE,
             traceplots=TRUE)


###Select which comparisons will be performed###
which.compare.list <- lapply(1:(length(networks$datasets)-1), function(i){
  which.compare.plot.1 <- cbind(c("Full-network", paste0("Network-",i)),
                                c("model-fixed.bug", "model-random.bug"),
                                c("Full-network-model-fixed", paste0("Network-",i,"-model-random")),
                                c("YES","NO"))
  colnames(which.compare.plot.1) <- c("Data","Model", "Description","Reference case for comparison")
  return(which.compare.plot.1)  #Reference case for comparison
}
)

cat("\nList of the posterior comparisons of interest:\n")
print(which.compare.list)

###Statistical comparisons###
out.results(inputs="inputs.general.R",
            which.analyses=which.analyses,
            which.compare.list=which.compare.list,
            revert.mapping = mapping.needed,
            metrics=TRUE,
            posteriors=print.posterior.plots)


###Close output file###
date()
sink()


