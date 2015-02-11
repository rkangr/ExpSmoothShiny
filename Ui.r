library(shiny)

shinyUI(fluidPage(
  titlePanel("Exponential smoothing"),
  
  sidebarLayout(
    sidebarPanel(
      
      helpText("Choose time series from a selection of sample datasets included with R, type of exponential smoothing and value(s) of smoothing parameter(s)"),
      selectInput("tseries", 
                  label = "Choose time series",
                  choices = list("AirPassengers", "BJsales",
                                 "ldeaths"),
                  selected = "AirPassengers"),
      radioButtons("type", "Smoothing type:",
                   c("Single" = "single",
                     "Double" = "double")),
      

      
      sliderInput("alpha", 
                  label = "alpha",
                  min = -1, max = 2, value = 0.5,step=0.05
      ),
      conditionalPanel(
        condition="input.type=='double'",
        sliderInput("beta", 
                  label = "beta",
                  min = -1, max = 2, value = 0.5,step=0.05
        )
      )
      , width=3),
    
    mainPanel(
      htmlOutput("txt1"),
      plotOutput("plot1")
      )
  )
))