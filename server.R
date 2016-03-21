
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

# 
# INPUTS:
#
# measurement - category : imperial or metric
# height      - numeric  : feet or meters
# weight      - numeric  : pounds or kilograms
# age         - numeric  : years
# situps      - numeric  : number of repetitions of sit-up exercise
#

library(shiny)

shinyServer(function(input, output) {
  
  # First, if imperial, convert to metric (courtesy of http://www.unitconversion.org/)
  getMeasure <- reactive ({input$measurement})
  height <- reactive ({
    if (getMeasure() == "Imperial") {
      input$height/100 * 0.3048
    } else {
      input$height/100
    }
  })
  weight <- reactive ({
    if (getMeasure() == "Imperial") {
      input$weight * 0.45359237
    } else {
      input$weight
    }
  })
  
  
  # perform calculations converting to silly Australiana versions of inputs from ui.R
  
  # height: a Red Kangaroo is around 1.5m tall (4.9 feet)
  hInRoos <- reactive ({
    height()/1.5
  })
  # weight : a wombat ranges from 20 - 35 kg.  We'll use 30kg (https://en.wikipedia.org/wiki/Wombat)
  wInWombats <- reactive ({
    weight()/30
  })
  # age : a platypus lives around 17 years.  A human averages 87 years. Thus 1 human year is 87/17 platy years
  aInPlatys <- reactive ({
    input$age*(87/17)
  })
  
  output$hInRoos <- renderPrint({hInRoos()})
  output$wInWombats <- renderText({wInWombats()})
  output$aInPlatys <- renderPrint({aInPlatys()})
    
  output$distPlot <- renderPlot({
    
    # The Basal Metabolic Rate (BMR) (expressed in 1000's of calories - kcal) is calculated using
    BMR <- 10*weight() +6.25 * height()/100 - 5*input$age
    # usually, the gender of the person alters the result +5 male -161 female.  But let's not ask!
    
    # Calories in a chocolate Bilby (http://www.haighschocolates.com.au/about-us/the-bilby/):
    # a 110g small milk chocolate bilby from Haighs Chocolates has 2508kJ (599,025.5calories) energy in it
    # The user will need ~ BMR/600 of these sweets to maintain basic functions per day
    
    # draw a curve
    # x axis is amount of chocolate eaten, y axis is amount of exercise required to remain at weight
    
    # for y = 0, x needs to = BMR/600
    # amount of energy consumed is x * 600.  
    # amount of energy used by situps (6) is - very roughly: 
    #   at 100pounds (45.3592kg) weight, 6 kcal burned per minute. Add 1 kcal per 10 pounds (4.53592kg)
    #   if you do 30 situps per minute you burn 6/30kcal per situp - 30 is rough average for most people
    kcalPerMinute <- weight()/4.53592 - 4
    kcalPerSitup <- kcalPerMinute/30
    
    # y = x - BMR/600 
    
    curve(x*600-BMR,0,30,
          xlab = "Qty of 110g Chocolate Bilby's",
          ylab = "Energy (kcal) to work off")
    
    # Place a vertical line on the graph showing how many bilby's can be eaten given the amount of
    # exercise
    mu <- input$situps * kcalPerSitup / 600
    phi <- mu*600-BMR
    
    lines(c(mu,mu), c(0,phi), col="green", lwd=7)
    lines(c(0,mu), c(phi,phi), col="green", lwd=7)
  })
  
})
