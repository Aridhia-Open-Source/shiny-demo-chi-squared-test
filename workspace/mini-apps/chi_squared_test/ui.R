


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
shinyUI(bootstrapPage(
  includeCSS("www/xapstyles.css"),
  headerPanel("Chi-squared Test"),
  
  
  mainPanel(width = 12,
            tabsetPanel(
              documentation_tab(),
              tabPanel(
                "Test of goodness of fit",
                radioButtons(
                  "dsSelect",
                  "Select data source",
                  choices = c("data", "raw", "tabular"),
                  selected = "raw",
                  inline = T
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'data'",
                  fluidRow(sidebarLayout(
                    sidebarPanel(
                      h2("Test of goodness of fit (From data source source)"),
                      xap.chooseDataTableUI("choose_data_gof"),
                      chooseSelectedColumnUI("choose_column_gof"),
                      br()
                    ),
                    mainPanel(
                      p('Please select dataset, then select variable'),
                      goodnessOfFitTestPlotUI("gof_test_data")
                    )
                  )),
                  fluidPage(goodnessOfFitTestUI("gof_test_data"))
                  
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'raw'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of goodness of fit (Raw data)"),
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
                    printSessionInfoUI("info1")
                  )
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'tabular'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of goodness of fit (Tabulated data)"),
                      h4("One nominal variable"),
                      aceReadCsvUI("gof_tab", placeholder = "Japanese,Thai,Chinese\n18,24,48")
                    ),
                    mainPanel(goodnessOfFitTestPlotUI("gof_test_tab"))
                  ),
                  fluidPage(
                    goodnessOfFitTestUI("gof_test_tab"),
                    printSessionInfoUI("info2")
                  )
                )
              ),
              tabPanel(
                "Test of Independence",
                radioButtons(
                  "dsSelect_toi",
                  "Select data source",
                  choices = c("data", "raw", "tabular"),
                  selected = "raw",
                  inline = T
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'data'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of goodness of fit (From data source)"),
                      xap.chooseDataTableUI("choose_data_toi"),
                      chooseSelectedColumnUI("choose_column_toi"),
                      chooseSelectedValueUI("choose_value_toi"),
                      chooseSelectedColumnUI("choose_column2_toi"),
                      chooseSelectedValueUI("choose_value2_toi")
                    ),
                    mainPanel(
                      p(
                        'Please select dataset, and then select 2 variables, and then select values of interest'
                      ),
                      testOfIndependencePlotsUI("toi_test_data")
                    )
                  ),
                  fluidPage(testOfIndependenceUI("toi_test_data"))
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'raw'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Independence (Raw data)"),
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
                    printSessionInfoUI("info3")
                  )
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'tabular'",
                  sidebarLayout(
                    sidebarPanel(
                      h2("Test of Independence (Tabulated data)"),
                      h4("Two or more than two nominal variables"),
                      aceReadCsvUI("toi_tab", placeholder = ",No,Yes\nM,20,18\nW,8,24")
                    ),
                    mainPanel(testOfIndependencePlotsUI("toi_test_tab"))
                  ),
                  fluidPage(
                    testOfIndependenceUI("toi_test_tab"),
                    printSessionInfoUI("info4")
                  )
                )
              )
            ))
))