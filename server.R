#- Need to clear columns when loading new dataset

#-------------------------------------------------------------------------------
#------------------------------------SOURCES------------------------------------
#-------------------------------------------------------------------------------
source("functions.R")
sourceDir("examples/")

#-------------------------------------------------------------------------------
#--------------------------------SERVER FUNCTION--------------------------------
#-------------------------------------------------------------------------------
server <- function(input, output, session) {
  # LOAD DATASET
  dataset_loaded <- reactiveVal(NULL)
  observeEvent(input$load_data, {
    dataset_name <- input$dataset
    dataset <- get(dataset_name)
    dataset_loaded(dataset)
    var_choices <- names(dataset)
    updateSelectInput(session, "x_var", choices = var_choices, selected = NULL)
    updateSelectInput(session, "y_var", choices = var_choices, selected = NULL)
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
    linear_regression_results(input, dataset)
  })
  
}