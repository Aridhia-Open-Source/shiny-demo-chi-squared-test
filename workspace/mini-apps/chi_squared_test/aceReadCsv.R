
# For CSV files only

aceReadCsvUI <- function(id, placeholder = "\n") {
  ns <- NS(id)
  
  tagList(
    p("Note: Data must have a header row (column names) and values must be separated by commas (,).
      Empty values and the string NA will be interpreted as NA"),
    aceEditor(ns("text"), value = placeholder,
              mode = "r", theme = "cobalt")
  )
}

aceReadCsv <- function(input, output, session) {
  
  dat <- reactive({
    readr::read_csv(input$text, na = c("", "NA"))
  })
  
  return(dat)
}


# Allow App Developer to choose the delimiter

aceReadDelimUI <- function(id, placeholder = "\n") {
  ns <- NS(id)
  
  tagList(
    uiOutput(ns("helptext")),
    aceEditor(ns("text"), value = placeholder,
              mode = "text", theme = "cobalt")
  )
}

aceReadDelim <- function(input, output, session, delim) {
  dat <- reactive({
    readr::read_delim(input$text, delim = delim)
  })
  output$helptext <- renderUI({
    p(
      paste0("Note: Data must have a header row (column names) and values must be separated by ",
             delim)
    )
  })
  return(dat)
}


# Allow App User to choose the delimiter

aceReadChooseDelimUI <- function(id, placeholder = "\n") {
  ns <- NS(id)
  
  tagList(
    radioButtons(ns("delim"), "Delimiter",
                 c("Comma (,)" = ",", "Semi-Colon (;)" = ";", "Colon (:)" = ":",
                   "Pipe (|)" = "|", "Tab" = "/t", "Space" = " "),
                 inline = TRUE),
    shinyAce::aceEditor(ns("text"), value = placeholder,
                        mode = "text", theme = "cobalt")
    
  )
  
}

aceReadChooseDelim <- function(input, output, session) {
  dat <- reactive({
    readr::read_delim(input$text, delim = input$delim, na = c("", "NA"))
  })
  return(dat)  
}



# shinyApp(
#   ui = fluidPage(
#     aceReadCsvUI("ace1"),
#     tableOutput("dt1"),
#     aceReadDelimUI("ace2"),
#     tableOutput("dt2"),
#     aceReadChooseDelimUI("ace3"),
#     tableOutput("dt3")
#   ),
#   server = function(input, output, session) {
#     dat1 <- callModule(aceReadCsv, "ace1")
#     output$dt1 <- renderTable(dat1())
#     dat2 <- callModule(aceReadDelim, "ace2", ";")
#     output$dt2 <- renderTable(dat2())
#     dat3 <- callModule(aceReadChooseDelim, "ace3")
#     output$dt3 <- renderTable(dat3())
#   }
# )
