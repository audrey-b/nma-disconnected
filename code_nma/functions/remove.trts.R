
remove.trts <- function(data, trts.to.remove, trts.name, trials.name){
  trials.remove <- get(trials.name,data[which(get(trts.name,data) %in% trts.to.remove),])
  sub.net <- data[-which(get(trials.name, data) %in% trials.remove),]
  return(sub.net)
  rm(list = ls())
}