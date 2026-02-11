#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#



# Define UI for application that draws a histogram
ui <- fluidPage(
  
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
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("linePlot"),
      plotOutput("barPlot")
    )
  )
)
