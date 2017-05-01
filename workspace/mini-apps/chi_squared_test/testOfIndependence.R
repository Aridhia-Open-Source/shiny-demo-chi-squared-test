

toi_pplot <- function(m) {
  nr <- nrow(m)
  nc <- ncol(m)
  tm <- as.vector(t(m))
  
  b <- rep(rowSums(m), each = nc)
  d <- tm/b
  
  zu <- matrix(rev(d), nrow = nr, ncol = nc, byrow = TRUE)[, nc:1]
  rownames(zu) <- rev(rownames(m))
  colnames(zu) <- colnames(m)
  
  par(mar=c(5,6,2,4))
  barplot(t(zu), hor=1, las=1, xlab="Percentage", col=gray.colors(nr))
  legend("bottomright", legend=colnames(zu), fill=gray.colors(nc))
}

try_fishers_exact_test <- function(m) {
  e <- try(fisher.test(m, workspace = 3000000), silent = FALSE)   # try, fisher.test
  if (class(e) == "try-error") {
    dd <- data.frame(c(""), c(""), c(""), c("data too large"))  # if error
    dd[1] <- c("Fisher's Exact Test")
    names(dd) <- c("method", "statistic", "parameter", "p.value")
    row.names(dd) <- NULL
  } else {
    d <- fisher.test(m, workspace=3000000)    # no error
    if (nrow(m) * ncol(m) == 4) { # Only for the 2×2 table
      dd <- data.frame(d[6], c(""), c(""), d[1])
    } else {
      dd <- data.frame(d[3], c(""), c(""), d[1])
    }
    dd[1] <- c("Fisher's Exact Test")
    names(dd) <- c("method", "statistic", "parameter", "p.value")
    row.names(dd) <- NULL
  }
  return(dd)
}

print_cramers <- function(m) {
  V <- sqrt(chisq.test(m, correct=F)$statistic[[1]] / 
              (sum(m) * (min(nrow(m), ncol(m) - 1))))
  fisherZ <- 0.5 * log((1 + V) / (1 - V))
  fisherZ.se <- 1 / sqrt(sum(m) - 3) * qnorm(1 - ((1 - 0.95) / 2))
  fisherZ.ci <- fisherZ + c(-fisherZ.se, fisherZ.se)
  ci.V <- (exp(2 * fisherZ.ci) - 1)/(1 + exp(2 * fisherZ.ci))
  
  cat("\n", "Cramer's V [95%CI] =", V, "[", ci.V[1], ",",ci.V[2],"]", "\n")
}

print_odds_ratio <- function(x) {
  if(ncol(x) != 2 || nrow(x) != 2) return()
  oddsrt <- (x[1,1]/x[1,2]) / (x[2,1]/x[2,2])
  oddsrt.log <- log((x[1,1]/x[1,2]) / (x[2,1]/x[2,2]))
  oddsrt.log.var <- 1/x[1,1] + 1/x[1,2] + 1/x[2,1] + 1/x[2,2]
  ci.lwrupr <- exp(oddsrt.log + qnorm(c(0.025,0.975)) * sqrt(oddsrt.log.var))
  cat("\n", "Odds Ratio [95%CI] =", oddsrt, "[", ci.lwrupr[1], ",",ci.lwrupr[2],"]", "\n")
}


testOfIndependenceUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    h3("Contingency table"),
    verbatimTextOutput(ns("contingency_table")),
    br(),
    h3("Test result"),
    verbatimTextOutput(ns("test")),
    br(),
    h3("Plots"),
    plotOutput(ns("pplot")),
    plotOutput(ns("mplot"), height = "550px")
  )
}

testOfIndependence <- function(input, output, session, m) {
  
  output$contingency_table <- renderPrint({
    x <- addmargins(m())
    print(x)
  })
  
  pearson_chi <- reactive({
    chisq.test(m(), correct = FALSE)
  })
  
  yates_chi <- reactive({
    chisq.test(m())
  })
  
  likelihood_ratio <- reactive({
    assocstats(m())
  })
  
  fishers_exact_test <- reactive({
    try_fishers_exact_test(m())
  })
  
  res <- reactive({
    a <- pearson_chi()
    b <- yates_chi()
    d <- likelihood_ratio()
    f <- fishers_exact_test()
    
    r <- data.frame(
      Test = c("Pearson's Chi-squared", "Yates' Continuity Correction", 
               "Log-likelihood Ratio (G)", "Fisher's Exact Test"),
      "X-squared" = c(round(a$statistic, 4), round(b$statistic, 4), round(d$chisq_tests[1, 1], 4), ""),
      "df" = c(a$parameter, b$parameter, d$chisq_tests[1, 2], ""),
      "p-value" = c(a$p.value, b$p.value, d$chisq_tests[1, 3], f[, 4])
    )
    return(r)
  })
  
  output$test <- renderPrint({
    print(res())
    cat("\n")
    cat("\n", "------------------------------------------------------", "\n",
        "Effect size:", "\n")
    print_cramers(m())
    print_odds_ratio(m())
    cat("\n", "\n", "------------------------------------------------------", "\n", "Residual analysis:", "\n")
    chi <- yates_chi()
    
    cat("\n", "[Expected values]", "\n")
    print(chi$expected)
    
    cat("\n", "[Standardized residuals]", "\n")
    print(chi$residuals)
    
    cat("\n", "[Adjusted standardized residuals]", "\n")
    print(chi$residuals / sqrt(outer(1 - rowSums(m()) / sum(m()), 1 - colSums(m())/sum(m()))))
    
    cat("\n", "[p-values of adjusted standardized residuals (two-tailed)]", "\n")
    print(round(2 * (1 - pnorm(abs(chi$residuals / sqrt(outer(1 - rowSums(m())/sum(m()), 1 - colSums(m())/sum(m())))))),3))
  })
  
  output$pplot <- renderPlot({
    toi_pplot(m())
  })
  
  output$mplot <- renderPlot({
    mosaic(m(), gp = shading_max, main = "Mosaic plot")
  })
  
}
