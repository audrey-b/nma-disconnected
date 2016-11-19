col.select.list <- function(list.of.datasets, col.names){
  if(length(col.names)==1){
    return(
      lapply(list.of.datasets, function(data, col.names)
        data[, which(colnames(data) %in% col.names)]
        , col.names )
    )
  }else{
    return(
      lapply(list.of.datasets, function(data, col.names)
        data[, which(colnames(data) %in% col.names)][col.names]
        , col.names )
    )
  }
}
