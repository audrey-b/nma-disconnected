if (Sys.info()["user"] == "Audrey.Beliveau"){
  workdir <- "C:/Users/Audrey.Beliveau/Documents/network-meta-analysis"
}

if (Sys.info()["user"] == "a.beliveau"){
  workdir <- "~/network-meta-analysis"
}

other.inputs <- "inputs.depression.6.debug.R"
source(other.inputs)

print.posterior.plots <- TRUE

vars.monitor <- c("sig2","d","alpha")
var.trt.names <- c("d")
var.trial.names <- c("alpha")

var.equiv.table <- data.frame(cbind(c(list("d"), list("alpha")),
                                    c(2, NA)))

rownames(var.equiv.table) <- c("t.id", "s.id")
colnames(var.equiv.table) <- c("Vars.monitored","Reference")

mapping.needed <- TRUE

