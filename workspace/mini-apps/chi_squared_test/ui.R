# attempt to load xapModules
l <-  xap.require.or.install("xapModules")
# if null then package was loaded from library
if (!is.null(l)) {
  # if FALSE then package was not found in repo
  if (!l) {
    # attempt to install from packages binaries included with the app
    pkg <- list.files("package_binaries", pattern = "xapModules*")
    utils::install.packages(file.path("package_binaries", pkg), repos = NULL)
  }
}

xap.require("shiny",
            "shinyAce",
            "pwr",
            "vcd",
            "readr")

source("aceReadCsv.R")
source("goodnessOfFitTest.R")
source("printSessionInfo.R")
source("testOfIndependence.R")
source("documentation_ui.R")
source('chooseColumn.R')
source('chooseValues.R')
shinyUI(bootstrapPage(fluidPage(
  theme = "xapstyles.css",
  tags$head(tags$style(
    HTML("
         .shiny-output-error { visibility: hidden; }
         ")
    )),
  headerPanel("Chi-squared Test"),
  
  
  mainPanel(width = 12,
            tabsetPanel(
              
              tabPanel(
                "Test of Goodness of Fit",
                fluidPage(
                tags$div(class = "tab", style = "margin-top: 15px;"),
                radioButtons(
                  "dsSelect",
                  "Select data source",
                  choices = c("workspace", "raw", "tabular"),
                  selected = "workspace",
                  inline = T
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'workspace'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Goodness of Fit (workspace data)"),
                      xap.chooseDataTableUI("choose_data_gof"),
                      chooseSelectedColumnUI("choose_column_gof")
                    ),
                    mainPanel(
                      p('Please select a data set, and then select a nominal variable:'),
                      goodnessOfFitTestPlotUI("gof_test_data")
                    )
                  ),
                  fluidPage(
                    goodnessOfFitTestUI("gof_test_data"),
                    printSessionInfoUI("info1")
                  )
                  
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'raw'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Goodness of Fit (raw data)"),
                      h4("One nominal variable"),
                      aceReadCsvUI(
                        "gof_raw",
                        paste0(
                          "L1\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\n",
                          "Japanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\n",
                          "Japanese\nJapanese\nJapanese\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\n",
                          "Thai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\n",
                          "Thai\nThai\nThai\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                          "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                          "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                          "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                          "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                          "Chinese\nChinese\nChinese\nChinese\nChinese"
                        )
                      )
                    ),
                    mainPanel(goodnessOfFitTestPlotUI("gof_test_raw"))
                    
                  ),
                  fluidPage(
                    goodnessOfFitTestUI("gof_test_raw"),
                    printSessionInfoUI("info2")
                  )
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'tabular'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Goodness of Fit (tabulated data)"),
                      h4("One nominal variable"),
                      aceReadCsvUI("gof_tab", placeholder = "Japanese,Thai,Chinese\n18,24,48")
                    ),
                    mainPanel(goodnessOfFitTestPlotUI("gof_test_tab"))
                  ),
                  fluidPage(
                    goodnessOfFitTestUI("gof_test_tab"),
                    printSessionInfoUI("info3")
                  )
                )
              )),
              tabPanel(
                "Test of Independence",
                fluidPage(
                tags$div(class = "tab", style = "margin-top: 15px;"),
                radioButtons(
                  "dsSelect_toi",
                  "Select data source",
                  choices = c("workspace", "raw", "tabular"),
                  selected = "workspace",
                  inline = T
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'workspace'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Independence (workspace data)"),
                      xap.chooseDataTableUI("choose_data_toi"),
                      chooseSelectedColumnUI("choose_column_toi"),
                      chooseSelectedValueUI("choose_value_toi"),
                      chooseSelectedColumnUI("choose_column2_toi"),
                      chooseSelectedValueUI("choose_value2_toi")
                    ),
                    mainPanel(
                      p(
                        'Please select a data set, and then select 2 nominal variables, and then select values of interest from those variables:'
                      ),
                      testOfIndependencePlotsUI("toi_test_data")
                    )
                  ),
                  fluidPage(
                    testOfIndependenceUI("toi_test_data"),
                    printSessionInfoUI("info4")
                  )
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'raw'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Independence (raw data)"),
                      h4("Two or more than two nominal variables"),
                      aceReadCsvUI(
                        "toi_raw",
                        placeholder = paste0(
                          "Sex,Effect\nM,No\nW,No\nW,No\nM,No\nM,Yes\nM,Yes\n",
                          "M,Yes\nM,No\nW,Yes\nM,No\nW,Yes\nM,No\nM,Yes\nM,No\n",
                          "M,No\nM,Yes\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nM,Yes\n",
                          "M,No\nM,No\nM,Yes\nM,Yes\nW,Yes\nM,No\nM,Yes\nW,Yes\n",
                          "M,No\nM,No\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nM,No\nW,No\n",
                          "W,Yes\nM,Yes\nW,Yes\nM,No\nM,Yes\nW,Yes\nM,Yes\nW,Yes\n",
                          "M,Yes\nM,No\nM,No\nW,No\nW,No\nM,Yes\nW,No\nM,Yes\n",
                          "W,Yes\nW,Yes\nM,No\nM,No\nM,Yes\nW,Yes\nM,No\nW,Yes\n",
                          "W,Yes\nM,Yes\nW,No\nW,Yes\nM,No\nW,Yes\nW,No\nM,Yes"
                        )
                      )
                    ),
                    mainPanel(testOfIndependencePlotsUI("toi_test_raw"))
                  ),
                  fluidPage(
                    testOfIndependenceUI("toi_test_raw"),
                    printSessionInfoUI("info5")
                  )
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'tabular'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Independence (tabulated data)"),
                      h4("Two or more than two nominal variables"),
                      aceReadCsvUI("toi_tab", placeholder = ",No,Yes\nM,20,18\nW,8,24")
                    ),
                    mainPanel(testOfIndependencePlotsUI("toi_test_tab"))
                  ),
                  fluidPage(
                    testOfIndependenceUI("toi_test_tab"),
                    printSessionInfoUI("info6")
                  )
                )
              )),
              documentation_tab()
            ))
    )))
