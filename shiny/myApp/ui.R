#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Plot Random Numbers"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      numericInput("numeric", "How many random numbers should be plotted?", value = 1000, min = 1, max= 1000, step = 1),
      
      sliderInput("sliderX", "Pick minimum and maximum X Values", -100, 100, value = c(-50, 50)),
      sliderInput("sliderY", "Pick minimum and maximum Y Values", -100, 100, value = c(-50, 50)),
      
      checkboxInput("show_x_lab", "Show/Hide X Axis LAbel", value = TRUE),
      checkboxInput("show_y_lab", "Show/Hide Y Axis LAbel", value = TRUE),
      checkboxInput("show_title", "Show/Hide X Title", value = TRUE)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Graph of random points"),
      plotOutput("plot1")
      )
  )
))
