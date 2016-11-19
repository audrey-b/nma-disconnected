
install.require.packages <- function(packages){
  
  uninstalled <- setdiff(packages, rownames(installed.packages()))
  
  if (length(uninstalled)!=0) install.packages(uninstalled, repos='http://cran.stat.sfu.ca/') #install packages if not installed
  
  invisible(lapply(packages, require, character.only = TRUE)) #require all packages
  rm(list = ls())
}