library(shiny)
library(ggplot2)
library(dplyr)
library(MASS)
library(rsconnect)

data("CO2")

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    # select variables depending of user input
    CO2=filter(CO2, grepl(input$Type, Type),
                    grepl(input$Treatment, Treatment))

    # build linear regresion model
    fit=lm(uptake~conc, CO2)
    
    # predicts the length of tooth growth
    pred=predict(fit, newdata=data.frame(conc=input$conc,
                                         Type=input$Type,
                                         Treatment=input$Treatment))
    
    # draw plot with ggplot2
    p1=ggplot(CO2, aes(x=conc, y=uptake))+
      geom_point(aes(color=Type), alpha=0.8)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept=input$conc, color = "red")+
      geom_hline(yintercept=pred, color = "blue")
    p1
  })
  
  output$result <- renderText({
    # renders the text for the prediction below the graph
    CO2=filter(CO2, grepl(input$Type, Type),
               grepl(input$Treatment, Treatment))
    
    fit=lm(uptake~conc, CO2)
    
    pred=predict(fit, newdata=data.frame(conc=input$conc,
                                         Type=input$Type,
                                         Treatment=input$Treatment))
    
    res=round(pred, digits = 1.5)
    res
  })
  
})


