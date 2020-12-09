
packages <- c("shiny",
            "shinyAce",
            "pwr",
            "vcd",
            "readr")


# Install the packages if not installed
if (!require(packages)){
  install.packages(packages)
}