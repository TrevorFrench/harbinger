library(shiny)

ui <- fluidPage(
  tags$head(tags$link(
    rel = "stylesheet",
    type = "text/css",
    href = paste("style.css", sep = "")
  ),
  tags$link(HTML("<link rel='icon' href='' type='image/png'>"))),
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
                          plotOutput("visualization"),
                          verbatimTextOutput("linear_regression_results")
                        )
                      )
             ),
             tabPanel("Linear Regression",
                      # verbatimTextOutput("linear_regression_results")
             )
  )
)