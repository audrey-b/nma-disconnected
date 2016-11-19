# Network Meta Analysis For Disconnected Networks

This project contains R code to explore the effect of using random baseline effects for the network meta analysis of disconnected networks. All data analyses are performed with JAGS through the runjags R package. You must have JAGS (https://sourceforge.net/projects/mcmc-jags/files/) installed on your machine to be able to run this code. 

We recommend that you follow the following steps to get familiar with the code in this project:

* Download the folder "code_nma" to your computer.
* Open the file "code_nma/inputs/inputs.general.R" and set "workdir" to be the directory that contains the "code_nma" folder on your machine.
* Run "code_nma/project.R". By default, "project.R" runs an analysis in debug mode (1 chain, 101 iterations) for of the depression dataset with a systematic sample of 4 disconnected networks with 6 disconnected treatments each.
  * If you encounter an error relative to the installation of packages, install them manually. A list of required packages can be found in the file "code_nma/header.R".
  * Have a look at the folder "output/". You should find the file "Routput.txt" which contains the output from the R console. In the folder "output/analysis/" you should find the results of the analyses (traceplots, posterior plots, Delta values). The folder "output/plots/" contains graphical representation of the networks used in the analyses. 
* Open the file "code_nma/inputs/inputs.depression.6.debug.R", change some of the user-specific settings to your liking and run "project.R" again with those new settings.
* Open "code_nma/inputs/inputs.general.R" and change "other.inputs <- "inputs.depression.6.debug.R"" to "other.inputs <- "inputs.diabetes.2.debug.R"". Then run "code_nma/project.R" again. This runs an analysis in debug mode (1 chain, 101 iterations) for the diabetes dataset with all possible networks that have 2 disconnected treatments each. We suggest that you use the debug mode until you are ready to run more iterations using "other.inputs <- "inputs.diabetes.2.R"" instead. Note that the "code_nma/input/" folder contains several other preset files to choose from in order to reproduce the results in our paper.
* If you would like to use your own dataset, set "other.inputs <- "inputs.custom.R"" and edit the file "functions/prep.data.custom.R" before running "code_nma/project.R".
