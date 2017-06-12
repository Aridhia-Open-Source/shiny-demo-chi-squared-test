documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
            fluidRow(column(
              6,
              h3("Chi-squared tests: goodness-of-fit and independence of nominal variables"), # paragraph and bold text
              p("This app allows you to perform a chi-squared test on nominal variables and test the degree of independence between different nominal
             variables. The data containing these variables can be selected from your workspace, or manually input in a raw or tabulated format."),
              br(),
              
              h4("App layout"),
              p("The app contains three tabs; this tab gives you an overview of the app itself. The Test of Goodness of Fit and Test of Independence 
             tabs contain a left-hand data selection sidebar and the output, displayed as both plots and statistical results."),
              br(),
              
              
              
              
              h4("To use the app"),
              p("To experiment with either test, first click on the relevant tab. From there, in the left-hand sidebar, you may click to select data
              either from the workspace, raw or tabulated manual input. If selecting data from the workspace, the Refresh Table List button can be
              used to update the list if datasets are changed."),
              p("When selecting variables, be sure to select NOMINAL variables only. If numeric variable such as age are selected, each category will 
              have a count of 1, and outputs will not display correctly."),
              
              tags$ol(
                tags$li("In the ", strong("Goodness of Fit tab, "), 
                        "use the drop-down menu to pick a first and second nominal variable, then select the values of interest which appear below the 
                      drop-down menus for each. "),
                tags$li("In the ", strong("Test of Independence tab,"), "use the drop-down menu to pick a first and second nominal variable, then 
                     select the values of interest which appear below the drop-down menus for each.")
              ),
              br(),            
              
              p("The results of each test display as visual plots next to the sidebar, with statistical outputs shown further down the page.")
            ),
            column(
              6,
              h3("Walkthrough Video"),
              
              
              HTML('<iframe width="100%" height="300" src="//www.youtube.com/embed/kL2oeaFmQ1Y?rel=0" frameborder="0" allowfullscreen = "allowfullscreen"></iframe>'),
              p(strong("NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's risk. If you plan to use this
                       mini-app to inform your study, please review the code and ensure you are comfortable with the calculations made before proceeding. ")
            ))
           
           
           
           )
           
           ))
}