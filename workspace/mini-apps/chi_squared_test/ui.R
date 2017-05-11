
xap.require(
  "shiny",
  "shinyAce",
  "pwr",
  "vcd",
  "readr"
)

source("aceReadCsv.R")
source("goodnessOfFitTest.R")
source("printSessionInfo.R")
source("testOfIndependence.R")

shinyUI(bootstrapPage(
  
  headerPanel("Chi-squared Test"),
  
  ########## Adding loading message #########
  
  tags$head(tags$style(type="text/css", "
                       #loadmessage {
                       position: fixed;
                       top: 0px;
                       left: 0px;
                       width: 100%;
                       padding: 10px 0px 10px 0px;
                       text-align: center;
                       font-weight: bold;
                       font-size: 100%;
                       color: #000000;
                       background-color: #CCFF66;
                       z-index: 105;
                       }
                       ")),
  
  conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                   tags$div("Loading...",id="loadmessage")),
  
  ########## Added up untill here ##########
  
  mainPanel(
    tabsetPanel(position = "left", selected = "Test of Independence (Tabulated data)",
                tabPanel("Test of goodness of fit (Raw data)",
                         h2("Test of goodness of fit (Raw data)"),
                         h4("One nominal variable"),
                         #p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         #p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         #aceEditor("text1", value="L1\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese", mode="r", theme="cobalt"),
                         aceReadCsvUI("gof_raw", paste0("L1\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\n",
                                      "Japanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\nJapanese\n",
                                      "Japanese\nJapanese\nJapanese\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\n",
                                      "Thai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\nThai\n",
                                      "Thai\nThai\nThai\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\nChinese\n",
                                      "Chinese\nChinese\nChinese\nChinese\nChinese")),
                         br(),
                         goodnessOfFitTestUI("gof_test_raw"),
                         printSessionInfoUI("info1")
                ),
                
                tabPanel("Test of goodness of fit (Tabulated data)",
                         h2("Test of goodness of fit (Tabulated data)"),
                         h4("One nominal variable"),
                         #p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         #p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         #aceEditor("text2", value="Japanese\tThai\tChinese\n18\t24\t48", mode="r", theme="cobalt"),
                         aceReadCsvUI("gof_tab", placeholder = "Japanese,Thai,Chinese\n18,24,48"),
                         br(),
                         goodnessOfFitTestUI("gof_test_tab"),
                         printSessionInfoUI("info2")
                ),
                
                tabPanel("Test of Independence (Raw data)",
                         h2("Test of Independence (Raw data)"),
                         h4("Two or more than two nominal variables"),
                         # p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         # p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         # aceEditor("text3", value="Sex\tEffect\nM\tNo\nW\tNo\nW\tNo\nM\tNo\nM\tYes\nM\tYes\nM\tYes\nM\tNo\nW\tYes\nM\tNo\nW\tYes\nM\tNo\nM\tYes\nM\tNo\nM\tNo\nM\tYes\nW\tYes\nW\tYes\nW\tYes\nW\tYes\nW\tYes\nM\tYes\nM\tNo\nM\tNo\nM\tYes\nM\tYes\nW\tYes\nM\tNo\nM\tYes\nW\tYes\nM\tNo\nM\tNo\nW\tYes\nW\tYes\nW\tYes\nW\tYes\nM\tNo\nW\tNo\nW\tYes\nM\tYes\nW\tYes\nM\tNo\nM\tYes\nW\tYes\nM\tYes\nW\tYes\nM\tYes\nM\tNo\nM\tNo\nW\tNo\nW\tNo\nM\tYes\nW\tNo\nM\tYes\nW\tYes\nW\tYes\nM\tNo\nM\tNo\nM\tYes\nW\tYes\nM\tNo\nW\tYes\nW\tYes\nM\tYes\nW\tNo\nW\tYes\nM\tNo\nW\tYes\nW\tNo\nM\tYes",mode="r", theme="cobalt"),
                         aceReadCsvUI("toi_raw", placeholder = paste0("Sex,Effect\nM,No\nW,No\nW,No\nM,No\nM,Yes\nM,Yes\n",
                                                                      "M,Yes\nM,No\nW,Yes\nM,No\nW,Yes\nM,No\nM,Yes\nM,No\n",
                                                                      "M,No\nM,Yes\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nM,Yes\n",
                                                                      "M,No\nM,No\nM,Yes\nM,Yes\nW,Yes\nM,No\nM,Yes\nW,Yes\n",
                                                                      "M,No\nM,No\nW,Yes\nW,Yes\nW,Yes\nW,Yes\nM,No\nW,No\n",
                                                                      "W,Yes\nM,Yes\nW,Yes\nM,No\nM,Yes\nW,Yes\nM,Yes\nW,Yes\n",
                                                                      "M,Yes\nM,No\nM,No\nW,No\nW,No\nM,Yes\nW,No\nM,Yes\n",
                                                                      "W,Yes\nW,Yes\nM,No\nM,No\nM,Yes\nW,Yes\nM,No\nW,Yes\n",
                                                                      "W,Yes\nM,Yes\nW,No\nW,Yes\nM,No\nW,Yes\nW,No\nM,Yes")
                                      ),
                         br(),
                         testOfIndependenceUI("toi_test_raw"),
                         printSessionInfoUI("info3")
                ),
                
                tabPanel("Test of Independence (Tabulated data)",
                         h2("Test of Independence (Tabulated data)"),
                         h4("Two or more than two nominal variables"),
                         # p('Note: Input values must be separated by tabs. Copy and paste from Excel/Numbers.'),
                         # p(HTML("<b><div style='background-color:#FADDF2;border:1px solid black;'>Your data needs to have the header (variable names) in the first row. Missing values should be indicated by a period (.) or NA.</div></b>")),
                         # aceEditor("text4", value="\tNo\tYes\nM\t20\t18\nW\t8\t24", mode="r", theme="cobalt"),
                         aceReadCsvUI("toi_tab", placeholder = ",No,Yes\nM,20,18\nW,8,24"),
                         br(),
                         testOfIndependenceUI("toi_test_tab"),
                         printSessionInfoUI("info4")
                )
                
                
                         
                )
    )
  )
  )