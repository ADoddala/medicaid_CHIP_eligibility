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




