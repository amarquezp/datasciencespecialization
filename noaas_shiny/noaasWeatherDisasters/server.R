#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {


  FILENAME      <- "noaas_tenmostharmfulevts.csv"
  NOAAS_DT      <- read.csv(FILENAME, header = TRUE, sep = ",",  quote = "\"")

  # Calculate the total of victims
  # Get the harmful events

  map_options <- list(
    scope = 'usa',
    showland = T,
    landcolor = toRGB("gray90"),
    showcountries = F,
    subunitcolor = toRGB("white")
  )

  borders <- list(color = toRGB("red"))

  output$value  <- renderPrint({ input$Event })
  evt_choices <- NOAAS_DT %>% distinct(EVTYPE) %>% select(EVTYPE)
  evt_choices$row <- 1:nrow(evt_choices)

  output$selectComponent <- renderUI(
                selectInput("Event", label = h3("Select Event Type"),
                             choices = as.character(unique(unlist(evt_choices[['EVTYPE']]))))
  )

  calculateNoaasData <- reactive({

    NOAAS_DT[NOAAS_DT$EVTYPE == input$Event, ] %>% group_by(EVTYPE, STATE) %>% arrange(desc(VICTIMS))

  })



  output$noaasMap <- renderPlotly({
    noaas_evtype_victims <- calculateNoaasData()
    plot_ly(noaas_evtype_victims, z=noaas_evtype_victims$VICTIMS, locations= noaas_evtype_victims$STATE,
            type='choropleth', locationmode= 'USA-states', color=noaas_evtype_victims$VICTIMS, colors='Blues',
            marker=list(line= borders)) %>% layout(title = paste('US ', input$Event,' Victims'), geo=map_options)

  })

})
