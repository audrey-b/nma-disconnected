
n.disconnected.nodes <- 4
ref.trt <- 2
data.fct.name <- "prep.data.depression"


#User-specific settings:

max.samples <- 4 #Maximum number of disconnected networks simulated
output.folder <- "output" #Name of the folder containing the results
RData.folder <- "RData_files" #Name of the folder containing the saved objects

n.chains <- 1 #Number of mcmc chains
n.adapt <- 101 #Number of adaptive iterations (tuning)
n.burnin <- 0 #Number of iterations in the burn-in period
n.samples <- 101 #Number of mcmc iterations
thin <- 1 #Thinning factor


