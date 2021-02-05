documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h3("Chi-squared tests"), 
                       p("This mini-app allows you to perform a chi-squared test on nominal variables and test the degree of independence between different nominal variables."),
                       h4("How to use the mini-app"),
                       p("Click on the relevant tab for the test you wish to perform. From there, in the left-hand sidebar, you can select which data source to use (file, raw or tabular)."),
                       p("When selecting variables, be sure to select NOMINAL variables only. If numeric variable such as age are selected, each category will 
              have a count of 1, and outputs will not display correctly and will not make sense."),
                       p("You can perform two kinds of Chi-squared tests with this app, each one located in a separate tab:"),
                       tags$ol(
                         tags$li("In the ", strong("Goodness of Fit tab, "), 
                                 "use the drop-down menu to pick a first and second nominal variable, then select the values of interest which appear below the 
                      drop-down menus for each. "),
                         tags$li("In the ", strong("Test of Independence tab,"), "use the drop-down menu to pick a first and second nominal variable, then 
                     select the values of interest which appear below the drop-down menus for each.")
                       ),
                       
                       p("The results of each test display as plots in the main panel, with statistical outputs shown further down the page."),
                       p("The examplar files used in this mini-app are located in the 'data' folder, you can save you own files there to use them in the mini-app.")
                     ),
                     column(
                       6,
                       h3("Walkthrough video"),
                       
                       
                       tags$video(src="chi-squared.mp4", type = "video/mp4", width="100%", height = "350", frameborder = "0", controls = NA),
                       p(class = "nb", "NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's risk. If you plan to use this mini-app to inform your study, please review the code and ensure you are comfortable with the calculations made before proceeding."
                       ))
                     
                     
                     
                     )
                     
           ))
}