library(shiny)

# Define UI for "Dataset Overview" application 
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Dataset Overview"),
    
    # Sidebar with controls to 1) select a dataset 
    # 2) specify the number of observations to view
    # 3) select one variable to view the descriptive summary
    # 4) select a pair of variables to view the pairwise scatter plot
    sidebarPanel(
        helpText("For demostration purpose, only 2 datasets are available here but 
                 the App can be extended to include as many as needed."),
        selectInput("dataset", "Choose a dataset:", 
                    choices = c("swiss", "mtcars")),
        
        br(),
        
        uiOutput("v1"),
        
        br(),
        
        uiOutput("vy"),
        
        br(),
        
        uiOutput("vx")      
    ),
    
    # Show a tabset that includes summary and plot
    mainPanel(
        tabsetPanel(
            tabPanel("Documentation", verbatimTextOutput("doc")), 
            tabPanel("Overview", verbatimTextOutput("table")), 
            tabPanel("Variable Summary", verbatimTextOutput("summary")), 
            tabPanel("Pair Plot", plotOutput("plot"))
        )
    )
))