library(shiny)
library(ggplot2)
library(datasets)
data(mtcars)
names(mtcars)=c("MPG","Num_Cylinders","Displacement","Gross_Horse_Power",
                "Rear_Axle_Ratio","Weight","Quarter_Mile_Time","VS",
                "Transmission","Num_Forward_Gears","Num_Carburetors")

shinyServer(function(input, output){ 
  output$plot = renderPlot({  
    output$otrans = renderText({input$transmission}) 
    
    if (length(input$transmission) == 2){
      data=mtcars
    }
    else if (length(input$transmission) == 1){
      data=mtcars[mtcars$Transmission == input$transmission,]
    }
    else {
      data=mtcars[mtcars$Transmission == input$transmission,]
      output$otrans = renderText("Error: Please select at least one transmission type!")
    }
    
    p = ggplot(data, aes_string(x=input$x, y="MPG")) + geom_point(color="firebrick", size=3) + theme_grey() +
      labs(title=paste("Relationship of MPG vs.", input$x, sep=" ")) +
      theme(plot.title=element_text(size=20, face="bold", vjust=2),
            axis.title.x=element_text(size=17),
            axis.title.y=element_text(size=17),
            axis.text.x=element_text(size=14),
            axis.text.y=element_text(size=14))

    if (input$smoother != "None") {
      p = p + stat_smooth(method=input$smoother, se=input$se, level=input$ci, color="darkblue", size=1.5)
    }

    print(p)      
  })
})
  