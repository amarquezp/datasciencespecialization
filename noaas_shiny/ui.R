#
# author: "Antonio Marquez Palacios"
# date: "April 23, 2018"
#
#

library(shiny)

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Visualize many models"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("Slope"),
      textOutput("slopeOut"),
      h3("Intercept"),
      textOutput("intOut")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot1", brush=brushOpts(id = "brush1"))
    )
  )
))
