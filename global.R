

# Packages ------------------------------------
library(shiny)
library(shinyAce)
library(pwr)
library(vcd)
library(readr)



# Source everything on the code folder --------------------------
for (file in list.files("code", full.names = TRUE)){
  source(file, local = TRUE)
}


source("config.R")
source("dependencies.R")