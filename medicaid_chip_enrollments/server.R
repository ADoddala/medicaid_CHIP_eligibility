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
  
  # Medicaid/ CHIP applications , eligibility determinations, enrollments over the time
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
  
  
  
  
  
  # Medicaid and CHIP Enrollments pre,covid, and Post covid periods
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
      "National Medicaid/CHIP enrollments during Covid, Pre covid, Post Covid "
    }else
    {
      paste("Medicaid/CHIP enrollments during Covid, Pre covid, Post Covid :" , input$state_name)
    }
    plot_data |> 
      mutate(time_phase = factor(time_phase, levels = c("Pre Covid", "Covid period", "Post Covid"), ordered = TRUE)) |>
      
      ggplot(aes(x = time_phase, y = monthly_total_enrollments)) +
      geom_col(fill = "#ea7270") +
      scale_y_continuous(
        labels = function(x) paste0(x / 1e6, "M")
      ) +
      labs(
        x = "Time Phase",
        y = "Total Enrollment (Millions)",
        title = title
      )
    
  })
  
  
  
  #Did the process time worsen during Covid period?
  
  output$stackedbarPlot <- renderPlot({
    plot_data <-  if(input$state_name!= "National"){
      medicaid_chip |> 
        filter(state_name == input$state_name)
    } else
      
    {
      medicaid_chip
    }
    
    plot_data <- plot_data |> 
      group_by(time_phase) |>  # grouped time phase to get pre,during and post Covid periods
      filter(!is.na(total_medicaid_and_chip_determinations_processed_in_less_than_24_hours)) |>  # filter non NA observations
      
      #summerise  processed times 
      summarise(less_than_24_hours = sum(total_medicaid_and_chip_determinations_processed_in_less_than_24_hours, na.rm=TRUE), 
                between_24_hours_and_7_days = sum(total_medicaid_and_chip_determinations_processed_between_24_hours_and_7_days,na.rm=TRUE),
                between_8_days_and_30_days = sum(total_medicaid_and_chip_determinations_processed_between_8_days_and_30_days,na.rm=TRUE),
                between_31_days_and_45_days= sum(total_medicaid_and_chip_determinations_processed_between_31_days_and_45_days,na.rm=TRUE),
                over_45days = sum(total_medicaid_and_chip_determinations_processed_in_more_than_45_days,na.rm=TRUE)
      ) |> 
      #create new column for total processing times and to get the fractions of each processing time
      mutate(
        total = less_than_24_hours+
          between_24_hours_and_7_days+
          between_8_days_and_30_days+
          between_31_days_and_45_days+
          over_45days,
        pct_less_than_24_hours = less_than_24_hours/total,
        pct_between_24_hours_and_7_days= between_24_hours_and_7_days/total,
        pct_between_8_days_and_30_days = between_8_days_and_30_days/total,
        pct_between_31_days_and_45_days= between_31_days_and_45_days/total,
        pct_over_45days = over_45days/total
      ) |> 
      pivot_longer(cols = starts_with("pct_"), #select all columns begin with pct
                   names_to = "processing_time",  # the column names like(pct_less_than_24_hours) will be stored in processing_time column
                   values_to= "count") |> # the values stored in these column will be go into new column count
      mutate(
        processing_time = factor(processing_time,
                                 levels = c("pct_less_than_24_hours" ,
                                            "pct_between_24_hours_and_7_days" ,
                                            "pct_between_8_days_and_30_days",
                                            "pct_between_31_days_and_45_days",
                                            "pct_over_45days" ),
                                 labels = c("< 24 Hours",
                                            "1–7 Days",
                                            "8–30 Days",
                                            "31–45 Days",
                                            "> 45 Days"),
                                 ordered =TRUE
        )
        
      ) 
    title <- if(input$state_name == "National"){
      "National Distribution of Processing times"
    }else
    {
      paste("Distribution of processing times :" , input$state_name)
    }
    plot_data |> 
      mutate(time_phase = factor(time_phase, levels = c("Pre Covid", "Covid period", "Post Covid"), ordered = TRUE)) |> #this tells which period come first
      ggplot(aes(x=time_phase, y=count, fill= processing_time))+ 
      geom_col()+
      scale_y_continuous(labels = scales::percent_format()) + # It changes how the numbers are displayed, It converts Y-axis fractions to percentages
      labs(
        x="Time Phase",
        y="share of eligibilty Determination",
        title=title
      )
    
  })
  
  
  
  
  
  #seasonal trends during pre,post and covid periods
  
  output$seasonalTrendlinePlot <- renderPlot({
    plot_data <-  if(input$state_name!= "National" ){
      medicaid_chip |> 
        filter(state_name == input$state_name)
      
    } else
      
    {
      medicaid_chip
    }
    
    plot_data <-  if(input$time_phase!= "All time Periods" ){
      plot_data |> 
        filter(time_phase == input$time_phase)
      
    } else
      
    {
      plot_data
    }
    plot_data <- plot_data |> 
      group_by(month_name) |> 
      summarise( avg_enrollments= mean(total_medicaid_and_chip_enrollment, na.rm=TRUE),
                 .groups = "drop" 
      ) |> 
      
      mutate(
        month_name = factor(month_name,
                            levels = month.name,
                            ordered =TRUE
                            
        )
      )
    
    title <- if(input$state_name == "National"){
      "National Average Monthly Medicaid/CHIP enrollment"
    }else
    {
      paste("Average Monthly Medicaid/CHIP enrollment :" , input$state_name)
    }
    plot_data |> 
      ggplot(aes(x=month_name, y=avg_enrollments, group=1)) +
      geom_line(color="#ea7270") +
      scale_y_continuous(
        labels = function(x) paste0(x / 1e6, "M")
      ) +
      labs(
        x = "Month",
        y = "Average Monthly  Enrollment (Millions)",
        title = title
      )
  })
  
}
