# Layout type: page with a sidebar
pageWithSidebar(
  headerPanel('Iris k-means clustering'),
  sidebarPanel(
    # sidebar panel with a slider, two dropdowns and a numeric input
    sliderInput(
      "bootstrap",
      "Bootstrap Size:",
      min = 150,
      max = 10000,
      value = 500
    ),
    selectInput('xcol', 'X Variable', setdiff(names(iris), "Species")),
    selectInput(
      'ycol',
      'Y Variable',
      setdiff(names(iris), "Species"),
      selected = names(iris)[[2]]
    ),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),
  # the cluster plot is displayed in the main pannel
  mainPanel(plotOutput('plot1'))
)