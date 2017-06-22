printSessionInfoUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    strong('R session info'),
    verbatimTextOutput(ns("info"))
  )
}

printSessionInfo <- function(input, output, session) {
  
  info <- reactive({
    info1 <- paste("This analysis was conducted with ", strsplit(R.version$version.string, " \\(")[[1]][1], ".", sep = "")
    info2 <- paste("It was executed on ", date(), ".", sep = "")
    cat(sprintf(info1), "\n")
    cat(sprintf(info2), "\n")
  })
  
  output$info <- renderPrint({
    info()
  })
}

