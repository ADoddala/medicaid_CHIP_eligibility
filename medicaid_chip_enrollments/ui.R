#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#



# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Impact of COVID-19 on Medicaid and CHIP enrollments"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("state_name",
                  "Select State:",
                  choices = c("National", medicaid_chip |>  
                                distinct(state_name) |> 
                                pull() |> 
                                sort())
      ),
      
      selectInput("time_phase",
                  "Select Time Phase:",
                  choices = c("All time Periods", medicaid_chip |>  
                                distinct(time_phase) |> 
                                pull() |> 
                                sort())
                  
                  
      )
      
    ),
    
    # Show a plot of the generated distribution
    
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Line Plot",
          plotOutput("linePlot",width = "750px"),
          plotOutput("lineappPlot",width = "900px")
        ),
        
        tabPanel(
          "Bar Plot",
          plotOutput("barPlot", height = "500px")
        ),
        
        tabPanel(
          "Stacked Bar Plot",
          plotOutput("stackedbarPlot", height="500px")
        ),
        tabPanel(
          "seasonal Trend linePlot",
          plotOutput("seasonalTrendlinePlot", height="500px")
        )
        
      )
    )
  )
)


