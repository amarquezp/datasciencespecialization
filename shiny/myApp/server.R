#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic 
shinyServer(function(input, output) {
  
  
  output$plot1 = renderPlot({
    
    set.seed(2018-03-27)
    numberOfPoints  <- input$numeric
    minX  <- input$sliderX[1]
    maxX  <- input$sliderX[2]
    minY  <- input$sliderY[1]
    maxY  <- input$sliderX[2]
    dataX <- runif(numberOfPoints, minX, maxX)
    dataY <- runif(numberOfPoints, minY, maxY)
    xlab  <- ifelse(input$show_x_lab, "X Axis", "")
    ylab  <- ifelse(input$show_y_lab, "Y Axis", "")
    main  <- ifelse(input$show_title, "Title", "")
    plot(dataX, dataY, xlab = xlab, ylab = ylab, main = main, xlim = c(-100, 100), ylim = c(-100,100))
    
  })
  
  
})
