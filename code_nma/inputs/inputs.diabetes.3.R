n.disconnected.nodes <- 3
max.samples <- 40
output.folder <- "output_diab_3"
RData.folder <- "RData_diab_3"
ref.trt <- 2

#MCMC parameters

n.chains <- 3
n.samples <- 300000
n.adapt <- 3000
thin <- 1
n.burnin <- 50000

data.fct.name <- "prep.data.diabetes" #Name of the function that prepares the dataset
