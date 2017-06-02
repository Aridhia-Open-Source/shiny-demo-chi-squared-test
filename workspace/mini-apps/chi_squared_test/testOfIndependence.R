

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
  barplot(t(zu), hor=1, las=1, xlab="Proportion", col=gray.colors(nr))
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

cramers_ci <- function(m, ci = 0.95) {
  V <- sqrt(chisq.test(m, correct = FALSE)$statistic[[1]] / 
              (sum(m) * (min(nrow(m), ncol(m)) - 1)))
  fisherZ <- 0.5 * log((1 + V) / (1 - V))
  fisherZ.se <- 1 / sqrt(sum(m) - 3) * qnorm(1 - ((1 - ci) / 2))
  fisherZ.ci <- fisherZ + c(-fisherZ.se, fisherZ.se)
  ci.V <- (exp(2 * fisherZ.ci) - 1) / (1 + exp(2 * fisherZ.ci))
  return(c(ci.V[1], V, ci.V[2]))
}

print_cramers <- function(m) {
  cv <- cramers_ci(m, 0.95)
  cat("\n", "Cramer's V [95%CI] =", cv[2], "[", cv[1], ",", cv[3], "]", "\n")
}

odds_ratio <- function(x, ci = 0.95) {
  if(ncol(x) != 2 || nrow(x) != 2) return()
  oddsrt <- (x[1, 1] / x[1, 2]) / (x[2, 1] / x[2, 2])
  oddsrt.log <- log((x[1, 1] / x[1, 2]) / (x[2, 1] / x[2, 2]))
  oddsrt.log.var <- sum(x^(-1))
  p <- (1 - ci) / 2
  ci.lwrupr <- exp(oddsrt.log + qnorm(c(p, 1 - p)) * sqrt(oddsrt.log.var))
  return(c(ci.lwrupr[1], oddsrt, ci.lwrupr[2]))
}

print_odds_ratio <- function(x) {
  or <- odds_ratio(x)
  cat("\n", "Odds Ratio [95%CI] =", or[2], "[", or[1], ",", or[3], "]", "\n")
}

comparison <- function(x) {
  if(nrow(x) != 2) {
    return()
  }
  comp <- paste(rownames(x)[1], "vs", rownames(x)[2])
  chi <- chisq.test(x, correct = FALSE)
  cv <- round(cramers_ci(x), 4)
  fisherp <- fisher.test(x)$p.value
  
  data.frame(
    Comparison = comp,
    X.2 = round(chi$statistic, 4),
    df = chi$parameter,
    p = chi$p.value,
    Fisher.p = fisherp,
    Cramers.V = cv[2],
    lwr.V = cv[1],
    upr.V = cv[3]
  )
}

all_comparisons <- function(x) {
  r <- row.names(x)
  l <- combn(r, 2, simplify = FALSE)
  comparisons <- lapply(l, function(a) {
    m <- x[a, ]
    return(comparison(m))
  })
  df <- do.call(rbind, comparisons)
  row.names(df) <- NULL
  df$p <- round(p.adjust(df$p, method = "bonferroni"), 4)
  df$Fisher.p <- round(p.adjust(df$Fisher.p, method = "bonferroni"), 4)
  return(df)
}

testOfIndependenceUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    h3("Contingency table"),
    verbatimTextOutput(ns("contingency_table")),
    br(),
    h3("Test result"),
    verbatimTextOutput(ns("test"))
  )
}

testOfIndependencePlotsUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    h3("Plots"),
    fluidRow(
      column(6,
             plotOutput(ns("pplot"))
             ),
      column(6,
             plotOutput(ns("mplot"))
             )
    )
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
    
    if(nrow(m()) == 2 && ncol(m()) == 2) {
      print_odds_ratio(m())
    }
    
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
    
    if(nrow(m()) > 2) {
      cat("\n", "\n", "------------------------------------------------------",
          "\n", "Multiple comparisons (p-value adjusted with Bonferroni method):",
          "\n", "\n")
      print(all_comparisons(m()))
    }
  })
  
  output$pplot <- renderPlot({
    toi_pplot(m())
  })
  
  output$mplot <- renderPlot({
    mosaic(m(), gp = shading_max)
  })
  
}
