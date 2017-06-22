



server <- function(input, output, session) {
  #----------------------------------------------------
  # 1. Test of goodness of fit (from Data source)
  #----------------------------------------------------
  
  ####FROM DATABASE
  df_gof <- callModule(xap.chooseDataTable, "choose_data_gof")
  dat <- df_gof$data
  # Pick the resulting variable
  res <-
    callModule(chooseSelectedColumn, "choose_column_gof", dat, label = "Pick a Nominal Variable")
  
  ####FROM TABLE
  dataFromTable_gof <- reactive({
    t <- table(res())
    x <- sort(t, decreasing = T)[1:5]
    x <- x[!is.na(names(x))]
    return(x)
  })
  callModule(goodnessOfFitTest, "gof_test_data", dataFromTable_gof)
  callModule(printSessionInfo, "info1")
  #----------------------------------------------------
  # 2. Test of goodness of fit (Raw data)
  #----------------------------------------------------
  d1 <- callModule(aceReadCsv, "gof_raw")
  tab_d1 <- reactive({
    table(d1())
  })
  
  callModule(goodnessOfFitTest, "gof_test_raw", tab_d1)
  callModule(printSessionInfo, "info2")
  
  #----------------------------------------------------
  # 3. Test of goodness of fit (Tabulated data)
  #----------------------------------------------------
  d2 <- callModule(aceReadCsv, "gof_tab")
  tab_d2 <- reactive({
    unlist(d2())
  })
  callModule(goodnessOfFitTest, "gof_test_tab", tab_d2)
  callModule(printSessionInfo, "info3")
  
  
  #----------------------------------------------------
  # 4. Test of independence (from Data source)
  #----------------------------------------------------
  
  ####FROM DATABASE
  df_toi <- callModule(xap.chooseDataTable, "choose_data_toi")
  dat_toi <- df_toi$data
  # Pick the resulting variable
  res_toi <-
    callModule(chooseSelectedColumn, "choose_column_toi", dat_toi, label = "Pick 1st Nominal Variable")
  
  
  res2_toi <-
    callModule(chooseSelectedColumn, "choose_column2_toi", dat_toi, label = "Pick 2nd Nominal variable")
  
  
  val_toi <-
    callModule(chooseSelectedValue, "choose_value_toi", res_toi, label = "Pick set of values")
  
  val2_toi <-
    callModule(chooseSelectedValue, "choose_value2_toi", res2_toi, label = "Pick 2nd set of values")
  
  ####FROM DATABASE
  dataFromTable_toi <- reactive({
    #Get V1
    A <- val_toi()
    #Get V2
    B <- val2_toi()
    #Find longest vector
    l <- max(length(A),length(B))
    #Make sure all are same length (Fill's with NA)
    length(A) <- l
    length(B) <- l
    #Organise
    d <- data.frame(A, B)
    #Get table
    out <- table(d)
    return(out)
  })
  
  callModule(testOfIndependence, "toi_test_data", dataFromTable_toi)
  callModule(printSessionInfo, "info4")
  #----------------------------------------------------
  # 5. Test of Independence (Raw data)
  #----------------------------------------------------
  
  d3 <- callModule(aceReadCsv, "toi_raw")
  m_d3 <- reactive({
    t <- table(d3())
    as.matrix(t)
  })
  
  callModule(testOfIndependence, "toi_test_raw", m_d3)
  
  callModule(printSessionInfo, "info5")
  
  #----------------------------------------------------
  # 6. Test of Independence (Tabulated data)
  #----------------------------------------------------
  
  d4 <- callModule(aceReadCsv, "toi_tab")
  m_d4 <- reactive({
    d <- as.data.frame(d4())
    m <- as.matrix(d[,-1])
    rownames(m) <- d[, 1]
    m
  })
  
  callModule(testOfIndependence, "toi_test_tab", m_d4)
  
  callModule(printSessionInfo, "info6")
}
