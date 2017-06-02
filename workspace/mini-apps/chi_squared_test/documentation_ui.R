documentation_tab <- function() {
  tabPanel("Information",
           # load MathJax library so LaTeX can be used for math equations
           withMathJax(), 
           h3("Chi-squared tests of Goodness of Fit, and Independence, of Nominal Variables"), # paragraph and bold text
           p("This app allows you to perform a chi-squared test on nominal variables, and test the degree of independence between different nominal
             variables. The data containing these variables can be selected from your workspace, or can be manually input in a raw or tabulated format."),
           
           h4("App Layout:"),
           p("The layout of the app contains three", strong("tabs,"),  
             "the first of which (Information) you are reading, and the other two containing the data selection ", strong("sidebar"),
              " and the output with the plots and statistical results."),

           
         
           
           h4("To use the app:"),
           p("To experiment with either goodness of fit or degree of independence of nominal variables, first click on the relevant tab. From there, in the ",
             strong("sidebar"), 
             " you may: "), 
            # ordered list
           tags$ol(
             tags$li("Use the  ", em("radio buttons "), 
                     "to select data either from the workspace, raw manual input or tabulated manual input. From the workspace option, the ", 
                      em("Refresh table list"), "button updates the table list if any workspace datasets are changed."), 
             tags$li("If selecting data from the workspace, use the ", em("drop down box "), 
                     "to choose a table from your workspace."), 
             tags$li("If in the Goodness of Fit tab, use the next", em("drop down box "), 
                     "to choose a nominal variable to test."), 
             tags$li("If in the Test of Independence tab, use the ", em("drop down boxes "),
                     "to pick a 1st and 2nd nominal variable, and then from the boxes below select the values of interest for each variable."),
             tags$li("The plots will appear next to the sidebar, with a variety of statistical test outputs created further down the page.")
            
             ),
           strong("When selecting variables, be sure to select NOMINAL variables only. If you select a numeric variable such as age, each category will have a count of 1,
                  and the plots will not display correctly."),
           br(),
           br(),
           p("The video below gives an overview on how to use the app:"),
           HTML('<iframe width="100%" height="500" src="//www.youtube.com/embed/rCDZzf4ragg" frameborder="0" allowfullscreen = "allowfullscreen"></iframe>'),
           p(strong("NB: This R Shiny app is provided unsupported and at user's risk. If you
                               are planning to use this app to inform your study, please review the
                    code and ensure you are comfortable with the calculations made.")
           )
           
           )
}