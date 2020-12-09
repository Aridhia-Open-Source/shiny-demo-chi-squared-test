
##################
####### UI #######
##################


shinyUI(bootstrapPage(fluidPage(
  
  
  # Style
  theme = "xapstyles.css",
  
  tags$head(tags$style(
    HTML("
         .shiny-output-error { visibility: hidden; }
         ")
    )),
  
  # Title
  headerPanel("Chi-Squared Test"),
  
  # Main Panel
  mainPanel(width = 12,
            
            # Division by tabs
            tabsetPanel(
              
              # Goodness of Fit Panel ------------------------------------------
              tabPanel(
                "Test of Goodness of Fit",
                
                fluidPage(
                  
                  # Side bar ---------------------------------------------------
                  tags$div(class = "tab", style = "margin-top: 15px;"),
                  
                  # Selection of data
                  radioButtons(
                    "dsSelect",
                    "Select data source",
                    choices = c("file", "raw", "tabular"),
                    selected = "file",
                    inline = T
                  ),
                  
                  # If user chooses to input data from a file, a slider input appears
                  conditionalPanel(
                    condition = "input['dsSelect'] == 'file'",
                    sidebarLayout(
                      sidebarPanel(
                        h2("Test of Goodness of Fit"),
                        # Choose dataset
                        chooseDataTableUI("choose_data_gof"),
                        # Choose column
                        chooseSelectedColumnUI("choose_column_gof")
                      ),
                      # Main Panel ---------------------------------------------
                      mainPanel(
                        p('Select a dataset, and then select a nominal variable:'),
                        
                        # Plot
                        goodnessOfFitTestPlotUI("gof_test_data")
                      )
                    ),
                    
                    # Test/Session information
                    fluidPage(
                      goodnessOfFitTestUI("gof_test_data"),
                      printSessionInfoUI("info1")
                    )
                    
                  ),
                  
                  # If user chooses raw data
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
                      # Main Panel ---------------------------------------------
                      mainPanel(goodnessOfFitTestPlotUI("gof_test_raw"))
                      
                    ),
                    
                    # Test/Session information
                    fluidPage(
                      goodnessOfFitTestUI("gof_test_raw"),
                      printSessionInfoUI("info2")
                    )
                  ),
                  
                  # If user chooses tabular data 
                  conditionalPanel(
                    condition = "input['dsSelect'] == 'tabular'",
                    sidebarLayout(
                      sidebarPanel(
                        h2("Test of Goodness of Fit (tabulated data)"),
                        h4("One nominal variable"),
                        aceReadCsvUI("gof_tab", placeholder = "Japanese,Thai,Chinese\n18,24,48")
                      ),
                      
                      # Main Panel ---------------------------------------------
                      mainPanel(goodnessOfFitTestPlotUI("gof_test_tab"))
                    ),
                    # Test/Session information
                    fluidPage(
                      goodnessOfFitTestUI("gof_test_tab"),
                      printSessionInfoUI("info3")
                    )
                  )
                )),
              
              
              # Test of Independence Panel -------------------------------------
              tabPanel(
                "Test of Independence",
                # Side bar
                fluidPage(
                  tags$div(class = "tab", style = "margin-top: 15px;"),
                  # Selection of data
                  radioButtons(
                    "dsSelect_toi",
                    "Select data source",
                    choices = c("file", "raw", "tabular"),
                    selected = "file",
                    inline = T
                  ),
                  
                  # If user chooses to input data from a file
                  conditionalPanel(
                    condition = "input['dsSelect_toi'] == 'file'",
                    sidebarLayout(
                      sidebarPanel(
                        h2("Test of Independence"),
                        chooseDataTableUI("choose_data_toi"),
                        chooseSelectedColumnUI("choose_column_toi"),
                        chooseSelectedValueUI("choose_value_toi"),
                        chooseSelectedColumnUI("choose_column2_toi"),
                        chooseSelectedValueUI("choose_value2_toi")
                      ),
                      
                      # Main Panel
                      mainPanel(
                        p(
                          'Select a dataset, select 2 nominal variables, and then select values of interest from those variables:'
                        ),
                        testOfIndependencePlotsUI("toi_test_data")
                      )
                    ),
                    
                    # Test/Session information
                    fluidPage(
                      testOfIndependenceUI("toi_test_data"),
                      printSessionInfoUI("info4")
                    )
                  ),
                  
                  # User chooses raw data
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
                      
                      # Main Panel
                      mainPanel(testOfIndependencePlotsUI("toi_test_raw"))
                    ),
                    
                    # Test/Session information
                    fluidPage(
                      testOfIndependenceUI("toi_test_raw"),
                      printSessionInfoUI("info5")
                    )
                  ),
                  
                  # User chooses tabular data
                  conditionalPanel(
                    condition = "input['dsSelect_toi'] == 'tabular'",
                    sidebarLayout(
                      sidebarPanel(
                        h2("Test of Independence (tabulated data)"),
                        h4("Two or more than two nominal variables"),
                        aceReadCsvUI("toi_tab", placeholder = ",No,Yes\nM,20,18\nW,8,24")
                      ),
                      
                      # Main Panel
                      mainPanel(testOfIndependencePlotsUI("toi_test_tab"))
                    ),
                    
                    # Test/Session information
                    fluidPage(
                      testOfIndependenceUI("toi_test_tab"),
                      printSessionInfoUI("info6")
                    )
                  )
                )),
              
              # Help tab -------------------------------------------------------
              documentation_tab()
            ))
    )))
