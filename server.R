library(shiny)
library(datasets)



# Define server logic for random distribution application
shinyServer(function(input, output) {
    
    # Reactive expression to generate the list of variable names in the selected dataset. 
    var <- reactive({
        switch(input$dataset,
               'swiss' = names(swiss),
               'mtcars' = names(mtcars))
        })
    
    output$v1 <- renderUI({
        selectInput("onevar", "Select the variable to view descriptive summary:", choices=var())
    })
    
    output$vy <- renderUI({
        selectInput("vary", "Select the variable on y-axis for pairwise plot:", choices=var())
    })
    
    output$vx <- renderUI({
        selectInput("varx", "Select the variable on x-axis for pairwise plot:", choices=var())
    })
    
    # documentation
    output$doc <- renderPrint({
        print(paste("If you see a variable not available, just click on other tabs and try again.  The dynamic feature is not very stable."), quote=FALSE)
        print(paste("This Shiny App allows you to select a dataset from the first dropdown menu and explore some basic information about the dataset.  After you select the dataset, the variable list will be updated according to the selected dataset.  The 'Overview' tab allows you to see what variables are included, their types, and the first few values.  The 'Variable Summary' tab allows you to view the univariate descriptive statistics of the selected variable from the second dropdown menu.  The 'Pair Plot' tab allows you to see the pairwise scatter plot of the two variables selected."), quote=FALSE)
    })
    
    # summary of dataset
    output$table <- renderPrint({
        str(get(input$dataset))
    })
        
    # summary of the onevar
    output$summary <- renderPrint({
        print(paste("Descriptive statistics of", input$onevar, sep=" "), quote=FALSE, row.names=FALSE)
        summary(get(input$onevar))
    })      
    
    # pairwise plot of varx and vary
    output$plot <- renderPlot({
        attach(get(input$dataset))
        plot(x=get(input$varx), y=get(input$vary), xlab=input$varx, ylab=input$vary)
    })
})