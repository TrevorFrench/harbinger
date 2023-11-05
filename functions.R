#-------------------------------------------------------------------------------
#--------------------------SOURCE DIRECTORY FUNCTION----------------------------
#-------------------------------------------------------------------------------
sourceDir <- function(path, trace = FALSE) {
  op <- options(); on.exit(options(op)) # to reset after each 
  for (nm in list.files(path, pattern = "*.R")) {
    if(trace) cat(nm,":")
    source(file.path(path, nm))
    if(trace) cat("\n")
    options(op)
  }
}

linear_regression_results <- function(input, dataset) {
  x_vars <- input$x_var
  y_var <- input$y_var
  if (!is.null(dataset) && length(x_vars) > 0 && !is.null(y_var)) {
    print('test')
    lm_formula <- as.formula(paste(y_var, "~", paste(x_vars, collapse = "+")))
    lm_model <- lm(lm_formula, data = dataset)
    summary(lm_model)
  }
}

