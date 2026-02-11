#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#




# Define server logic required to draw a line plot

function(input, output, session) {
  
    output$linePlot <- renderPlot({
    plot_data <-  if(input$state_name!= "National"){
      medicaid_chip |> 
        filter(state_name == input$state_name)
    } else
    {
      medicaid_chip
    }
    plot_data <- plot_data |> 
      group_by(reporting_period) |> 
      summarise( total_enrollments= sum(total_medicaid_and_chip_enrollment, na.rm=TRUE),
                 total_new_applications = sum(total_applications_for_financial_assistance_submitted_at_state_level, na.rm=TRUE),
                 total_eligibility_determination = sum(total_medicaid_and_chip_determinations, na.rm=TRUE),
                 .groups = "drop" 
      ) 
    
    title <- if(input$state_name == "National"){
      "National Medicaid/CHIP enrollment"
    }else
    {
      paste("Medicaid/CHIP enrollment :" , input$state_name)
    }
    plot_data |> 
      ggplot(aes(x=reporting_period)) +
      geom_line(aes(y=total_new_applications, color="Total New Applications")) +
      geom_line(aes(y=total_eligibility_determination, color="Total Eligibility Determinations")) +
      geom_line(aes(y=total_enrollments, color="Total Enrollments")) +
      
     #geom_line(color = "blue") +
      scale_y_continuous(
        labels = function(x) paste0(x / 1e6, "M")
      ) +
      labs(
        x = "Year",
        y = "Total Enrollment (Millions)",
        title = title
      )
    })
  
  
  
  
  
  
  output$barPlot <- renderPlot({
    plot_data <-  if(input$state_name!= "National"){
      medicaid_chip |> 
        filter(state_name == input$state_name)
    } else
      
    {
      medicaid_chip
    }
    
    plot_data <- plot_data |> 
      group_by(time_phase) |> 
      summarise( monthly_total_enrollments= sum(total_medicaid_and_chip_enrollment, na.rm=TRUE),
                 .groups = "drop"
      ) 
    title <- if(input$state_name == "National"){
      "National Medicaid/CHIP enrollment"
    }else
    {
      paste("Medicaid/CHIP enrollment :" , input$state_name)
    }
    plot_data |> 
      mutate(time_phase = factor(time_phase, levels = c("Pre Covid", "Covid period", "Post Covid"), ordered = TRUE)) |>
      
      ggplot(aes(x = time_phase, y = monthly_total_enrollments)) +
      geom_col(color = "blue") +
      scale_y_continuous(
        labels = function(x) paste0(x / 1e6, "M")
      ) +
      labs(
        x = "Time Phase",
        y = "Total Enrollment (Millions)",
        title = title
      )
    
  })
  
}
