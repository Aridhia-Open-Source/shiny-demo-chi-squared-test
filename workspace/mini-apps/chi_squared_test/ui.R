

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

shinyUI(bootstrapPage(
  headerPanel("Chi-squared Test"),
  
  
  mainPanel(width = 12,
            tabsetPanel(
              documentation_tab(),
              tabPanel(
                "Test of goodness of fit",
                radioButtons(
                  "dsSelect",
                  "Select data source",
                  choices = c("raw", "tabular"),
                  selected = "raw",
                  inline = T
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'raw'",
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
                  ),
                  br(),
                  goodnessOfFitTestUI("gof_test_raw"),
                  printSessionInfoUI("info1")
                ),
                conditionalPanel(
                  condition = "input['dsSelect'] == 'tabular'",
                  h2("Test of goodness of fit (Tabulated data)"),
                  h4("One nominal variable"),
                  aceReadCsvUI("gof_tab", placeholder = "Japanese,Thai,Chinese\n18,24,48"),
                  br(),
                  goodnessOfFitTestUI("gof_test_tab"),
                  printSessionInfoUI("info2")
                )
              ),
              tabPanel(
                "Test of Independence",
                radioButtons(
                  "dsSelect_toi",
                  "Select data source",
                  choices = c("raw", "tabular"),
                  selected = "raw",
                  inline = T
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'raw'",
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
                  ),
                  br(),
                  testOfIndependenceUI("toi_test_raw"),
                  printSessionInfoUI("info3")
                ),
                conditionalPanel(
                  condition = "input['dsSelect_toi'] == 'tabular'",
                  h2("Test of Independence (Tabulated data)"),
                  h4("Two or more than two nominal variables"),
                  aceReadCsvUI("toi_tab", placeholder = ",No,Yes\nM,20,18\nW,8,24"),
                  br(),
                  testOfIndependenceUI("toi_test_tab"),
                  printSessionInfoUI("info4")
                )
              )
            ))
))