#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(ggplot2)
library(markdown)

storeData <- read.csv('dataCourseProject.csv', header = TRUE, sep = ';')
storeList <- unique(storeData$Store)

shinyUI(
  navbarPage("Sports Shopping Center Mall", 
     tabPanel(".:: Sales Forecasting ::.",
        titlePanel("Sales Forecasting"),
        sidebarPanel(
            selectInput('store', 'Store:', as.character(storeList)),
            sliderInput('month', 'Month to forecast:', min=1, max=36,
                                    value=20, step=1, round=0),
            helpText("Download forecasting result in .csv file."),
            downloadButton('downloadData','Download Result') 
        ),
        mainPanel(
            h3('Selected store: '), verbatimTextOutput('storeSelected'),
            plotOutput('plot')
        )
      ), # end of "Sales Forecasting" tab panel
      tabPanel(".:: About ::.",
          mainPanel(
            includeMarkdown("about.md")                      
          )
      ) # end of "About" tab panel
   )
)

