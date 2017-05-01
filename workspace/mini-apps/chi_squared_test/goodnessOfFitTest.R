

effect_size <- function(a, b) {
  n <- a + b
  z <- (abs(a - b) - 1) / sqrt(n)
  p <- pnorm(z, lower.tail = FALSE) * 2
  p <- p.adjust(p, method = "bonferroni", n = length(x))
  p00 <- c(0.5, 0.5)
  p11 <- c(a, b) / n
  p0 <- p00[1]
  p1 <- p11[1]
  ESg <- p1 - p0
  return(list("z" = round(z, 3), "p" = round(p, 3), "ESg" = round(ESg, 3)))
}

pplot <- function(x, expected = NULL) {
  if(is.null(expected)) {
    P0 <- rep(1 / length(x), times = length(x))  # Expected ratio
  } else {
    P0 <- expected / sum(expected)
  }
  P1 <- x / sum(x)                               # Observed ratio
  
  par(mar = c(5,6,2,4))
  z <- matrix(c(P0, P1), nc = length(x), by = 1)
  colnames(z) <- names(x)
  rownames(z) <- c("Expected", "Observed")
  barplot(t(z), hor = 1, las = 1, xlab = "Percentage", col = gray.colors(length(x)))
  
  legend("bottomright",legend = colnames(z), fill = gray.colors(length(x)))
}

goodnessOfFitTestUI <- function(id) {
  ns <- NS(id)
  tagList(
    h3("Contingency table"),
    verbatimTextOutput(ns("contingency_table")),
    br(),
    h3("Test result"),
    verbatimTextOutput(ns("test")),
    br(),
    h3("Plot"),
    plotOutput(ns("plot"))
  )
}

goodnessOfFitTest <- function(input, output, session, tab) {
  
  output$contingency_table <- renderPrint({
    n <- sum(tab())
    x <- c(tab(), Sum=n)
  
    print(x)
  })
  
  test <- reactive({
    chi <- chisq.test(tab())
    print(chi)
    
    P0 <- rep(1/length(x), times = length(x))  # Expected ratio
    P1 <- x/sum(x)                             # Observed ratio
    w <- ES.w1(P0, P1)                         # Effect size w (Large=0.5, Medium=0.3, Small=0.1)
    
    cat("Effect size w =", round(w, 3), "\n")
    
    cat("\n", "---", "\n", "Multiple comparisons (p-value adjusted with Bonferroni method):", "\n", "\n")
    
    for (i in 1:length(chi$observed)) {
      for (j in 1:length(chi$observed)) {
        if (i <= j) {next}
        a <- effect_size(chi$observed[[i]], chi$observed[[j]])
        cat(names(x)[j], "vs", names(x)[i], ":", "z =", sprintf("%.3f", a$z), ",",
            "p =", sprintf("%.3f", a$p),
            ",", "Effect size g =", a$ESg, "\n"
        )
      }
    }
  })
  
  output$test <- renderPrint({
    test()
  })
  
  output$plot <- renderPlot({
    x <- tab()
    pplot(x)
  })
}
