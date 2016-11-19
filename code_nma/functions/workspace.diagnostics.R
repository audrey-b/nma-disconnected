workspace.diagnostics <- function(){
  
  workspace.objects <- ls(.GlobalEnv)
  objects.mem <- sapply(workspace.objects, function(x) object.size(get(x)))
  objects.mem.frame <- data.frame(round(sort(objects.mem, decreasing=TRUE)/sum(objects.mem)*100))
  colnames(objects.mem.frame) <- c("% of total size")
  cat("Total memory used: ", sum(objects.mem)/10^9," Gb\n")
  head(objects.mem.frame)
}