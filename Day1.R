# Day 1, Making sure we have the right version
R.version$version.string # oops. I don't. I need to update this

## This is how to save packages before updating
#' Save R packages to a file. Useful when updating R version
#'
#' @param path path to rda file to save packages to. eg: installed_old.rda
save_packages <- function(path){
  tmp <- installed.packages()
  installedpkgs <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
  save(installedpkgs, file = path)
}

#' Update packages from a file. Useful when updating R version
#' 
#' @param path path to rda file where packages were saved
update_packages <- function(path){
  tmp <- new.env()
  installedpkgs <- load(file = path, envir = tmp)
  installedpkgs <- tmp[[ls(tmp)[1]]]
  tmp <- installed.packages()
  
  installedpkgs.new <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
  missing <- setdiff(installedpkgs, installedpkgs.new)
  install.packages(missing)
  update.packages()
}

save_packages("installed.rda")
#Now, update R
#next reinstall packages
update_packages("installed.rda")

#next see what RStudio version
RStudio.Version()$version #up to date!

#next, making sure all packages are update and installed
packages <- c("DT", "dataone", "datapack", "devtools", "dplyr", "EML", "ggmap", "ggplot2", "leaflet", "readxl", "tidyr", "scales", "sf", "rmarkdown", "roxygen2", "usethis", "broom", "captioner")

for (package in packages) { if (!(package %in% installed.packages())) { install.packages(package) } }

rm(packages) #remove variable from workspace

#Now we are setting up Git and GitHub
#Need to work in terminal

#intro to R module
#open new R markdown
