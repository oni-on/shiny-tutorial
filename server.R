# generates a bootstrap sample and adds noise to the numeric variables
# the function is accessible by the server across all session
BootstrapJitter <- function(dataset, samplesize) {
  numeric.vars <- names(which(sapply(dataset, class) == "numeric"))
  dataset <-
    dataset[sample(1:nrow(dataset), size = samplesize, replace = T),]
  dataset[, numeric.vars] <- sapply(dataset[, numeric.vars],
                                    function(x)
                                      x + rnorm(nrow(dataset), mean = 5))
}

function(input, output) {
  # reactive dataset: bootstrap based on user input
  iris.boot <-
    reactive(BootstrapJitter(iris, samplesize = input$bootstrap))
  
  # Combine the selected variables into a new data frame
  # selectedData is a reactive conductor created from the reactive source (input)
  # reactive expressions are accessed using expression()
  selectedData <- reactive({
    iris.boot()[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  # This plot is a reactive endpoint
  output$plot1 <- renderPlot({
    palette(
      c(
        "#E41A1C",
        "#377EB8",
        "#4DAF4A",
        "#984EA3",
        "#FF7F00",
        "#FFFF33",
        "#A65628",
        "#F781BF",
        "#999999"
      )
    )
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(
      selectedData(),
      col = clusters()$cluster,
      pch = 20,
      cex = 3
    )
    points(clusters()$centers,
           pch = 4,
           cex = 4,
           lwd = 4)
  })
  
}