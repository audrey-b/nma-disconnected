
n.disconnected.nodes <- 6

max.samples <- 4 #Maximum number of disconnected networks simulated

output.folder <- "output" #Name of the folder containing the results
RData.folder <- "RData_files" #Name of the folder containing the saved objects

ref.trt <- 2

#MCMC parameters

n.chains <- 1 #Number of mcmc chains
n.samples <- 101 #Number of mcmc iterations
n.adapt <- 101 #Number of adaptive iterations (tuning)
thin <- 1 #Thinning factor
n.burnin <- 0 #Number of iterations in the burn-in period

#Function's name for data sampling

data.fct.name <- "prep.data.depression"
