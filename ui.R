library(shiny)
library(ggplot2)
library(datasets)
data(mtcars)
names(mtcars)=c("MPG","Num_Cylinders","Displacement","Gross_Horse_Power",
                "Rear_Axle_Ratio","Weight","Quarter_Mile_Time","VS",
                "Transmission","Num_Forward_Gears","Num_Carburetors")

shinyUI(pageWithSidebar(
  headerPanel("Motor Car MPG Explorer!"),
  sidebarPanel(
    selectInput('x','Relationship of MPG vs. ...?',choices = names(mtcars)[-1]),
    tags$hr(), 
    h5('Uncheck if interested in a particular transmission type only (Optional):'),
    checkboxGroupInput('transmission', "Transmission:", 
                       choices = c("Automatic" = "0", "Manual" = "1"),
                       selected = c("Automatic" = "0", "Manual" = "1")),
    tags$br(), 
    h5('Aid pattern visualization (Optional):'),
    selectInput('smoother', 'Add a smoother',
                choices = c("None", "loess","lm", "glm", "gam", "rlm")),
    
    checkboxInput('se', 'Show confidence interval around smoother?',
                  value = TRUE),
    sliderInput('ci', 'Adjust level of confidence interval:',
                value = 0.95, min=0.9, max=1, step=0.005),
    tags$br(),
    helpText("Data source: Motor Trend US magazine (1974)")
  ),
  mainPanel(
    plotOutput('plot')
  )
))

