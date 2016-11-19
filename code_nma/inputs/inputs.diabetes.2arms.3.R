n.disconnected.nodes <- 3
max.samples <- 100
output.folder <- "output_diab_2arms_3"
RData.folder <- "RData_diab_2arms_3"
ref.trt <- 2

#MCMC parameters

n.chains <- 3
n.samples <- 300000
n.adapt <- 3000
thin <- 1
n.burnin <- 50000

#Function's name for data sampling

data.fct.name <- "prep.data.diabetes.2arms"
