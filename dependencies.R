
packages <- c("shiny",
            "shinyAce",
            "pwr",
            "vcd",
            "readr")


# Install the packages if not installed
package_install <- function(x){
  for (i in x){
    # Check if package is installed
    if (!require(i, character.only = TRUE)){
      install.packages(i)
    }
  }
}

package_install(packages)