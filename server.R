#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(forecast)
library(dplyr)

function(input, output) {
  
  output$storeSelected <-  renderPrint({input$store})
  
  dataStore <- reactive({
    storeList <- read.csv('dataCourseProject.csv', header = TRUE, sep = ';')
    storeList[storeList$Store == input$store, c('Total.Sales')]
  })
  
  dataStoreForecast <- reactive({
      serie <- ts(dataStore(), frequency=12, start=c(2014,1))
      fit <- HoltWinters(serie)
      prediction <-  forecast(fit, input$month)
      prediction
  })
  
  output$plot <- renderPlot({
      serie <- ts(dataStore(), frequency=12, start=c(2014,1))
      fit <- HoltWinters(serie)
      
      prediction <-  forecast(fit, input$month)
      plot(prediction)
  }, height=480)
  
  output$downloadData <- downloadHandler(
    file = c('dataStoreForecastResult.csv'),
    content = function(file1) {
      write.csv(dataStoreForecast(), file = file1)
    }
  )
}
