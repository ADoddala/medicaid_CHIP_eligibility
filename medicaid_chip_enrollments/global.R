library(shiny)
library(tidyverse)
library(lubridate)
library(scales)
library(glue)

medicaid_chip <- read_csv("../data/medicaid_chip.csv")

medicaid_chip <- medicaid_chip |> 
  mutate(
    time_phase =  case_when(
      reporting_period < ymd("2020-03-01")  ~ "Pre Covid",
      between(ymd(reporting_period), ymd("2020-03-01"), ymd("2023-03-31")) ~ "Covid period",
      reporting_period >= ymd("2023-04-01") ~ "Post Covid"
    ) 
  ) 


medicaid_chip <- medicaid_chip |> 
  mutate (
    total_processed = total_medicaid_and_chip_determinations_processed_in_less_than_24_hours +
                      total_medicaid_and_chip_determinations_processed_between_24_hours_and_7_days+
                      total_medicaid_and_chip_determinations_processed_between_8_days_and_30_days+
                      total_medicaid_and_chip_determinations_processed_between_31_days_and_45_days+
                      total_medicaid_and_chip_determinations_processed_in_more_than_45_days
  )

  #pct_over_45days = total_medicaid_and_chip_determinations_processed_in_more_than_45_days/total_processed
  