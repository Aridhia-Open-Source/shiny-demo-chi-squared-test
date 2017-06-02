
chooseValueUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("choose_value_ui"))
}

chooseValue <- function(input, output, session, data, label = "Select a Value:") {
  ns <- session$ns
  
  values <- reactive({
    ud <- unique(data())
    return(ud)
  })
  
  output$choose_value_ui <- renderUI({
    v <- values()
    selectizeInput(ns("choose_value"), label, choices = v, multiple = T,
                selected = v[1:5])
    
  })
  
  out <- reactive({
    req(input$choose_value)
    d <- data()
    d[d %in% input$choose_value]
  })
  
  return(out)
}

chooseSelectedValueUI <- function(id) {
  ns <- NS(id)
  chooseValueUI(ns("choose_value"))
}

chooseSelectedValue <- function(input, output, session, data, label) {
  callModule(chooseValue, "choose_value", data = data, label = label)
}
