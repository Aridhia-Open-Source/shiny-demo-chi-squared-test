
chooseColumnUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("choose_column_ui"))
}

chooseColumn <- function(input, output, session, data, label = "Select a Column:", selected = 1) {
  ns <- session$ns
  
  columns <- reactive({
    
    names(data())
  })
  
  output$choose_column_ui <- renderUI({
    v <- columns()
    selectInput(ns("choose_column"), label, choices = v,
                selected = v[min(c(length(v), selected))])
  })
  
  values <- reactive({
    
    req(input$choose_column)
    req(input$choose_column %in% names(data()))
    data()[[input$choose_column]]
  })
  
  return(values)
}

chooseSelectedColumnUI <- function(id) {
  ns <- NS(id)
  chooseColumnUI(ns("choose_column"))
}

chooseSelectedColumn <- function(input, output, session, data, label, selected = 1) {
  callModule(chooseColumn, "choose_column", data = data, label = label, selected = selected)
}
