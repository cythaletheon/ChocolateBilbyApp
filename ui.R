
# The Chocolate Bilby Safe Consumption Calculator
#
# Create by Damon Grummet
# On the 21st Of March 2016
# As an assignment response for Coursera/Johns Hopkins MOOC course 'Data Products' - a part
# of the Data Science Specialization.
#
# This package ONLY requires the 'Shiny' library.
#
# CLIENT UI COMPONENT
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("The Chocolate Bilby Safe Consumption Calculator"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    h3('Please enter your vital statistics here:'),
    radioButtons(inputId="measurement", label=h4("Metric (cm|kg) or Imperial (feet|pounds)?"),
                 choices = list("Metric", "Imperial"),
                 selected = "Metric"),
    numericInput('height', 'Height:', 170, min = 50, max = 300, step=1),
    #numericInput('height', 'Height in Kangaroos (1Ks ~= 1.5m / 4.9f)', 1.2, min = 0.3, max = 2, step=0.1),
    numericInput('weight', 'Weight:', 80, min = 10, max = 800, step=1),
    #numericInput('age', 'Age in platypus years (They live 17 years in captivity)')
    sliderInput("age",
                "Age in years:",
                min = 1,
                max = 150,
                value = 25),
    h3('Use this slider to adjust your planned level of Easter Exercise:'),
    sliderInput("situps",
                "Number of Sit-Ups:",
                min = 1,
                max = 50000,
                value = 300)
  ),
  
  # Show the calculated results
  mainPanel(
    h1("Ever wonder just how many situps do you need to do over Easter to allow you to eat as many ",
            tags$a(href="http://www.haighschocolates.com.au/about-us/the-bilby/", target="_blank", "Chocolate Bilbies"),
            " as you want?"
    ),
    h4("On the left, set your personal data, and use the SitUp slider to set your commitment level. Below
       you will see a graph of number of Chocolate Bilbies consumed versus amount of energy you need
       to work off.  Do more Situps and you can eat more Bilbies!"),
    p("Please note, these calculations use the standard 110g Milk Chocolate Bilby from Haighs Chocolates as the reference energy source."),
    plotOutput("distPlot"),
    h3(textOutput("lazyMax")),
    p(""),
    h3("Here are some interesting facts, useful if you visit Australia ;-)"),
    h4(textOutput("aInPlatys")),
    h4(textOutput("hInRoos")),
    h4(textOutput("wInWombats"))
  )
))
