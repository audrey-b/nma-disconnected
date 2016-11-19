n.disconnected.nodes <- 2
max.samples <- 40
output.folder <- "output_diab_2arms_2"
RData.folder <- "RData_diab_2arms_2"
ref.trt <- 2

#MCMC parameters

n.chains <- 3
n.samples <- 300000
n.adapt <- 3000
thin <- 1
n.burnin <- 50000

#Function's name for data sampling

data.fct.name <- "prep.data.diabetes.2arms"
