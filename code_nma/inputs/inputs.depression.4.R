
n.disconnected.nodes <- 4

max.samples <- 10

if(!("output.folder" %in% ls())){
output.folder <- paste0("out_",
                        #format(Sys.time(), "%m-%d-%Y-%Hh%M"),
                        #"_",
                        "dep",
                        n.disconnected.nodes)
}

if(!("RData.folder" %in% ls())){
RData.folder <- paste0("RData_",
                       #format(Sys.time(), "%m-%d-%Y-%Hh%M"),
                       #"_",
                       "dep",
                       n.disconnected.nodes)
}

ref.trt <- 2

#MCMC parameters

n.chains <- 3
n.samples <- 150000
n.adapt <- 3000
thin <- 1
n.burnin <- 50000

#Function's name for data sampling

data.fct.name <- "prep.data.depression"
