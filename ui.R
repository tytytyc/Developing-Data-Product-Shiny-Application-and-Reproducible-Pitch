library(shiny)

# Define UI for application that draws a plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("CO2: Carbon Dioxide Uptake in Grass Plants"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("To predict the carbon dioxide uptake rates of the grass species Echinochloa crus-galli."),
      h3(helpText("Select:")),
      sliderInput("conc", label = h4("Ambient carbon dioxide concentrations (mL/L)"),
                  min = 1, max = 1000,
                  value = 500),
      radioButtons("Type", label = h4("Origin of the plant"),
                  choices = c("Quebec", "Mississippi")),
      radioButtons("Treatment", label = h4("Treatment"),
                  choices = c("nonchilled", "chilled"))
    ),
    
    # Show the plot
    mainPanel(
      plotOutput("distPlot"),
      h3(textOutput("result"))
    )
  )
))

