
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Situps versus Chocolate Bilby's?"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    h1('Personal Data'),
    h2('Please enter your vital statistics here:'),
    radioButtons(inputId="measurement", label=h4("Metric (cm|kg) or Imperial (feet|pounds)?"),
                 choices = list("Metric", "Imperial"),
                 selected = "Metric"),
    numericInput('height', 'Height:', 180, min = 50, max = 300, step=1),
    #numericInput('height', 'Height in Kangaroos (1Ks ~= 1.5m / 4.9f)', 1.2, min = 0.3, max = 2, step=0.1),
    numericInput('weight', 'Weight:', 90, min = 10, max = 800, step=1),
    #numericInput('age', 'Age in platypus years (They live 17 years in captivity)')
    sliderInput("age",
                "Age in years:",
                min = 0.1,
                max = 150,
                value = 25),
    h2('Use this slider to adjust your level of Easter Exercise:'),
    sliderInput("situps",
                "Number of Sit-Ups:",
                min = 1,
                max = 50000,
                value = 300)
    #,submitButton('Calculate!')
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    h1("How many situps do you need to do over Easter to allow you to eat as many Chocolate Bilbys as you
     want?"),
    h4("On the left, set your personal data, and use the SitUp slider to set your commitment level."),
    plotOutput("distPlot"),
    h4('Your Age in Platypus Years:'),
    verbatimTextOutput("aInPlatys"),
    h4('Your weight in Wombats'),
    verbatimTextOutput("wInWombats"),
    h4('Your Height in Kangaroos'),
    verbatimTextOutput("hInRoos")
  )
))
