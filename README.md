
# Analysis of the impact of Covid-19 on medicaid CHIP Enrollments
***

>

## Motivation
***

>
>I chose this Project because Medicaid and CHIP help many people get health insurance especially with low income. It’s important to understand how many people apply and enroll in these programs, and how this changes to over time. Events like COVID-19 pandemic may have affected enrollment, and different states may have different results. By studying this data, we can learn more about how well these programs are working and where improvements might needed .
>

## Purpose
***

>
>The Purpose of this Project is to discover the trends of  medicaid and CHIP(children's Health Insurance Program) applications, eligibility determinations and enrollments over time and primarily answer the following questions:
>
>>* How were Medicaid and CHIP enrollments,applications, eligibility determinations effected by COVID-19 across States?  
>>* Are there any seasonal trends or monthly patterns in medicaid and CHIP enrollment patterns across states?  
>>* How was the processing time distribution across States/ National and time phases(Pre Covid, Covid, post Covid)?  
>

## Data 
***

>
>The primary data set https://data.medicaid.gov/dataset/6165f45b-ca93-5bb5-9d06-db29c692a360 used in this project is State Medicaid and CHIP Applications, Eligibility Determinations, and Enrollment Data provided by the centers for Medicare and Medicaid Services (CMS). 
>
>This data set contains monthly state-level information about Medicaid and CHIP applications, eligibility determinations and enrollment counts reported by individual states.  
>
>Data set cleaned in Python via the below guidelines.  
>
>>* Drop Duplicates based on preliminary or updated report.  
>>* Having Records from 2017 because before 2017 only have few records with 2013.  
>>* Changed data type and column names.  
>  
>Prior to cleaning data set includes 10K+ records but after cleaning data set included 5K+ records.  
>

## App Demo
***

>
>Live Version available at: https://adoddala.shinyapps.io/medicaid_chip_enrollments/. 
>
>The graph at above link consists of five plots.  
>
>>* The first line plot sorted by year on x-axis and total number of enrollments on y axis. The plot can be filter by state using the select input boxes on the left side of the plot.  
>>* The second plot in the same page shows the total number of applications versus eligibility determinations over the time period. This plot also can be filter by State.  
>>* The third plot is a bar plot, which shows number of enrollments during different time phases(pre Covid, Covid period and post Covid). The plot contains time phase on x axis and number of enrollments on y axis.This plot can be filtered by state.  
>>* The fourth plot is a stacked bar plot shows the processing times(<24 hours, 1day to 7days, 7days to 30 days,30days to 45 days, more than 45 days) of share of eligibility determination distribution. The plot contains time phase on x axis and share of processing times of eligibility determination on y axis.  And it can be filter by State.  
>>* The final plot is a line plot, which shows the seasonal monthly trends of enrollments . The line plot is sorted by year on x-axis and total number of enrollments on y axis. The plot can be filter by state and time phase using select input boxes on the left side of plot.  
>
   
## Data insights
***

>

### Medicaid and CHIP enrollment trends. 

>
>>* Enrollment was stable pre-COVID.  
>>* Continuous enrollment policy significantly increased total Medicaid/CHIP enrollment.  
>>* During Covid enrollments exceeded to 90 million beneficiaries.  
>>* Decline began post-policy expiration.  
>  

### Applicatins vs Eligibility Determinations

> 
>>* Compares incoming applications with eligibility determinations
>>* Application Indicates demand for coverage
>>* Eligibility Determinations helps assess administrative responsiveness
>>* Average monthly applications declined during COVID.
>>* Continuous enrollment reduced the need for renewals and new applications.
>>* Applications increased sharply after the policy ended due to redeterminations.
>

### Enrollment across Time phases

>
>>* Enrollments were Higher During covid Period.
>>* Structural expansion observed.
>  
 
### Eligibility Determination Processing Time Distribution

>
>>* Administrative processing times varied across time phases and states.
>>* Shows share of determinations by processing time
> 

### Seasonal Enrollment Patterns

>
>>* State-level variation suggests important policy and operational differences.
>>* Examines average monthly enrollment
>>* Identifies recurring seasonal patterns
>>* Evaluates stability across time periods



 
 






