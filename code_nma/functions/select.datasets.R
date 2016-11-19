select.datasets <- function(data, 
                            trt.names.data.frame, 
                            ref.trt, 
                            size, 
                            max.samples){
  
  potential.sets <- combn(setdiff(unique(data$t.id), ref.trt), size)
  new.networks <- list()
  
  tot.arms <- NULL
  n.disconnected.arms <-NULL
  
  for(i in 1:dim(potential.sets)[2]){
    with.disc.column <- cbind(data[-which(colnames(data) == "s.id")], stack((
      lapply(
        as.list(unstack(data[,c("t.id","s.id")])), 
        function(x) x %in% potential.sets[,i]))))
    with.disc.column$ind <- data$s.id
    with.disc.column$s.id <- data$s.id
    tble <- table(with.disc.column[,c("values","ind")])
    false.remove <- as.numeric(names(which(tble["FALSE",]==1)))
    true.remove <- as.numeric(names(which(tble["TRUE",]==1)))
    new.networks[[i]] <- with.disc.column[-which((with.disc.column$ind %in% false.remove) & (with.disc.column$values==FALSE)),]
    new.networks[[i]] <- new.networks[[i]][-which((new.networks[[i]]$ind %in% true.remove) & (new.networks[[i]]$values==TRUE)),]
    tot.arms <- c(tot.arms, dim(new.networks[[i]])[1])
    n.disconnected.arms <- c(n.disconnected.arms, length(which(new.networks[[i]]$values == TRUE)))
    new.networks[[i]]$values <- NULL
    new.networks[[i]]$ind <- NULL
  }
  
  #Remove networks that have the wrong sizes
  remove.which <- NULL
  for(i in 1:dim(potential.sets)[2]){
    n.disconnected <- length(intersect(potential.sets[,i], unique(new.networks[[i]]$t.id)))
    n.principal <- length(setdiff(unique(new.networks[[i]]$t.id), potential.sets[,i]))
    if(!(n.disconnected == size && n.principal>=2)){
      remove.which <- c(remove.which, i)
    }
  }
  
  if(!is.null(remove.which)){
    potential.sets <- potential.sets[,-remove.which]
    new.networks[remove.which] <- NULL
    tot.arms <- tot.arms[-remove.which]
    n.disconnected.arms <- n.disconnected.arms[-remove.which]
  }
  
  #Remove networks that have more than 2 subnetworks
  
  remove.which <- NULL
  
  for(i in 1:dim(potential.sets)[2]){
    t0 <- potential.sets[,i][1]
    s <- new.networks[[i]][which(new.networks[[i]]$t.id == t0),"s.id"]
    t <- unique(new.networks[[i]][which(new.networks[[i]]$s.id %in% s),]$t.id)
    success <- all.equal(sort(potential.sets[,i]), sort(t))
    finished <- success
    while(finished != TRUE){
      t0 <- t
      s0 <- s
      s <- new.networks[[i]][which(new.networks[[i]]$t.id %in% t),"s.id"]
      t <- unique(new.networks[[i]][which(new.networks[[i]]$s.id %in% s),]$t.id)
      success <- all.equal(sort(potential.sets[,i]), sort(t))
      finished <- (success==TRUE) | (length(s)==length(s0) & length(t)==length(t0))
    }
    if(success != TRUE) remove.which <- c(remove.which, i)
  }
  if(!is.null(remove.which)){
    potential.sets <- potential.sets[,-remove.which]
    new.networks[remove.which] <- NULL
    tot.arms <- tot.arms[-remove.which]
    n.disconnected.arms <- n.disconnected.arms[-remove.which]
  }
  
  for(i in 1:dim(potential.sets)[2]){
    non.disconnected.trts <- setdiff(unique(new.networks[[i]]$t.id), potential.sets[,i]) 
    t0 <- non.disconnected.trts[1]
    s <- new.networks[[i]][which(new.networks[[i]]$t.id == t0),"s.id"]
    t <- unique(new.networks[[i]][which(new.networks[[i]]$s.id %in% s),]$t.id)
    success <- all.equal(sort(non.disconnected.trts), sort(t))
    finished <- success
    while(finished != TRUE){
      t0 <- t
      s0 <- s
      s <- new.networks[[i]][which(new.networks[[i]]$t.id %in% t),"s.id"]
      t <- unique(new.networks[[i]][which(new.networks[[i]]$s.id %in% s),]$t.id)
      success <- all.equal(sort(non.disconnected.trts), sort(t))
      finished <- (success==TRUE) | (length(s)==length(s0) & length(t)==length(t0))
    }
    if(success != TRUE) remove.which <- c(remove.which, i)
  }
  if(!is.null(remove.which)){
    potential.sets <- potential.sets[,-remove.which]
    new.networks[remove.which] <- NULL
    tot.arms <- tot.arms[-remove.which]
    n.disconnected.arms <- n.disconnected.arms[-remove.which]
  }
  
  cat("\nNumber of possible disconnected networks:", ncol(potential.sets),"\n")
  
  #Take a sample of networks
  order.n.links <- order(tot.arms) #smaller to larger
  new.networks <- new.networks[order.n.links]
  potential.sets <- potential.sets[,order.n.links]
  tot.arms <- tot.arms[order.n.links]
  n.disconnected.arms <- n.disconnected.arms[order.n.links]
  
  if(length(new.networks)>max.samples){
    pi=1/rep(length(new.networks),length(new.networks))*max.samples
    
    remove.which <- which(UPsystematic(pi)==0)
    
    potential.sets <- potential.sets[,-remove.which]
    new.networks[remove.which] <- NULL
    tot.arms <- tot.arms[-remove.which]
    n.disconnected.arms <- n.disconnected.arms[-remove.which]
  }
  
  names(new.networks) <- sapply(1:length(new.networks), function(x) paste0("Network-",x))
  
  for (j in 1:length(new.networks)) {
    plot.network(
      paste0(output.folder,"/plots/disconnected_network", j, ".pdf"),
      new.networks[[j]],
      "Network",
      trt.names.data.frame
    )
  }
  
  cat("\nNetwork graphs were added in",paste0("/",output.folder,"/plots/"),"\n")
  
  network.charact <- data.frame(cbind(tot.arms, n.disconnected.arms, n.disconnected.arms/tot.arms))
  colnames(network.charact) <- c("Tot.arms","Total.disc.arms", "%")
  rownames(network.charact) <- names(new.networks)
  
  sink(paste0(output.folder,"/datasets-description.txt"))
  cat(date(), "\n\nDisconnected datasets:\n\n")
  print(network.charact, row.names = TRUE)
  sink()
  
  #Treatments that form the core network (as opposed to the disconnected part)
  core.t.id <- matrix(data=NA, nrow=length(unique(data$t.id))-dim(potential.sets)[1],ncol=length(new.networks))
  for(i in 1:length(new.networks)){
    t.id.in.network <- setdiff(unique(new.networks[[i]]$t.id),potential.sets[,i])
    core.t.id[1:length(t.id.in.network),i] <- t.id.in.network
  }
  
  return(list("datasets" = new.networks,
              "core.t.id"=core.t.id,
              "disconnected.t.id" = potential.sets))
  rm(list = ls())
  
}