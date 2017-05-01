

server <- function(input, output, session) {
  #----------------------------------------------------
  # 1. Test of goodness of fit (Raw data)
  #----------------------------------------------------
  d1 <- callModule(aceReadCsv, "gof_raw")
  tab_d1 <- reactive({
    table(d1())
  })
  
  callModule(goodnessOfFitTest, "gof_test_raw", tab_d1)
  callModule(printSessionInfo, "info1")
  
  #----------------------------------------------------
  # 2. Test of goodness of fit (Tabulated data)
  #----------------------------------------------------
  d2 <- callModule(aceReadCsv, "gof_tab")
  tab_d2 <- reactive({
    unlist(d2())
  })
  
  callModule(goodnessOfFitTest, "gof_test_tab", tab_d2)
  callModule(printSessionInfo, "info2")
  
  #----------------------------------------------------
  # 3. Test of Independence (Raw data)
  #----------------------------------------------------
  
  d3 <- callModule(aceReadCsv, "toi_raw")
  m_d3 <- reactive({
    t <- table(d3())
    as.matrix(t)
  })
  
  callModule(testOfIndependence, "toi_test_raw", m_d3)
  
  callModule(printSessionInfo, "info3")
  
  #----------------------------------------------------
  # 4. Test of Independence (Tabulated data)
  #----------------------------------------------------
  
  d4 <- callModule(aceReadCsv, "toi_tab")
  m_d4 <- reactive({
    d <- as.data.frame(d4())
    m <- as.matrix(d[, -1])
    rownames(m) <- d[, 1]
    m
  })
  
  callModule(testOfIndependence, "toi_test_tab", m_d4)
  
  callModule(printSessionInfo, "info4")
}

