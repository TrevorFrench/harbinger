library(shiny)

# Define UI for the application
ui <- fluidPage(
  navbarPage("HARBINGER",
             tabPanel("Visualization",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("dataset", "Select a Dataset", choices = c("mtcars", "iris")),
                          actionButton("load_data", "Load Data"),
                          selectInput("y_var", "Select Y Variable", choices = NULL),
                          selectInput("x_var", "Select X Variable(s)", choices = NULL, multiple = TRUE)
                        ),
                        mainPanel(
                          plotOutput("visualization")
                        )
                      )
             ),
             tabPanel("Linear Regression",
                      verbatimTextOutput("linear_regression_results")
             )
  )
)

# Define server logic
server <- function(input, output, session) {
  dataset_loaded <- reactiveVal(NULL)
  
  observeEvent(input$load_data, {
    dataset_name <- input$dataset
    dataset <- get(dataset_name)
    dataset_loaded(dataset)
    
    x_var_choices <- names(dataset)
    print(x_var_choices)
    updateSelectInput(session, "x_var", choices = x_var_choices, selected = NULL)
    updateSelectInput(session, "y_var", choices = x_var_choices, selected = NULL)
  })
  
  output$visualization <- renderPlot({
    dataset <- dataset_loaded()
    x_vars <- input$x_var
    y_var <- input$y_var
    
    if (!is.null(dataset) && length(x_vars) > 0 && !is.null(y_var)) {
      plot_data <- dataset[, c(x_vars, y_var)]
      plot_data <- na.omit(plot_data)
      plot(plot_data)
    }
  })
  
  output$linear_regression_results <- renderPrint({
    dataset <- dataset_loaded()
    x_vars <- input$x_var
    y_var <- input$y_var
    
    if (!is.null(dataset) && length(x_vars) > 0 && !is.null(y_var)) {
      lm_formula <- as.formula(paste(y_var, "~", paste(x_vars, collapse = "+")))
      lm_model <- lm(lm_formula, data = dataset)
      summary(lm_model)
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
