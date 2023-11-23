library(shiny)
library(colourpicker)
library(shinythemes)
source("R/simulate_data.R")
source("R/plot_sample_means.R")

# Construct the user interface for the Shiny app
ui <- fluidPage(theme = shinytheme("flatly"),
  
  # Create the app title
  titlePanel("Central Limit Theorem Simulator"),
  
  sidebarLayout(
    
    # Sidebar panel for the user to input their desired values
    sidebarPanel(
      
      # Let the user choose a probability distribution
      selectInput(
        inputId = "distribution", 
        label = "Choose a distribution:",
        choices = c("Beta", "Gamma", "Normal")
      ),
      
      # # Let the user choose the parameters of the Beta distribution
      conditionalPanel(
        condition = "input.distribution == 'Beta'",
        numericInput("param_1",
                     "Choose the first parameter of the Beta distribution:",
                     value = 1,
                     min = 0),
        numericInput("param_2",
                     "Choose the second parameter of the Beta distribution:",
                     value = 1,
                     min = 0)
      ),
      
      # Lets the user choose the parameters of the Gamma distribution
      conditionalPanel(
        condition = "input.distribution == 'Gamma'",
        numericInput("param_1",
                     "Choose the shape parameter of the Gamma distribution:",
                     value = 1,
                     min = 0),
        numericInput("param_2",
                     "Choose the rate parameter of the Gamma distribution:",
                     value = 1,
                     min = 0)
      ),
      
      # Lets the user choose the parameters of the Normal distribution
      conditionalPanel(
        condition = "input.distribution == 'Normal'",
        numericInput("param_1",
                     "Choose the mean of the Normal distribution:",
                     value = 0),
        numericInput("param_2",
                     "Choose the standard deviation of the Normal distribution:",
                     value = 1,
                     min = 0)
      ),
      
      # Lets the user change the sample size
      numericInput(
        inputId = "sample_size",
        label = "Select the sample size for the simulated sample means:",
        value = 1, 
        min = 1, 
        max = 250
      ),
      
      # Lets the user change the number of simulations
      numericInput(
        inputId = "n_simulations",
        label = "How many sample means should be simulated?",
        value = 1000, 
        min = 100, 
        max = 10000,
        step = 100
      ),

      # Lets the user change the colours in the histogram
      colourpicker::colourInput(
        inputId = "bin_colour",
        label = "Select the colour of the histogram's bins:",
        value = "#006699"
      ),
      colourpicker::colourInput(
        inputId = "bin_outline",
        label = "Select the colour of the outline of the bins:",
        value = "#000000"
      ),
      colourpicker::colourInput(
        inputId = "hist_background",
        label = "Select the colour of the background of the histogram:",
        value = "#DEDEDE"
      ),
      
      # Lets the user change the number of bins in the histogram
      numericInput(
        inputId = "n_bins",
        label = "Number of bins in the histogram:",
        value = 30, 
        min = 10, 
        max = 60
      )
    ),
    
    # Code for the main panel
    mainPanel(
      h5("The Central Limit Theorem states that for any random variable with a 
          well-defined mean, the sample mean of n independent observations
          from that distribution converges to a Normal distribution."),
      h5("Using this tool, we can empirically look at this convergence in
         distribution."),
      plotOutput(outputId = "means_plot"),
      # Button to click to resample the data 
      actionButton(
        inputId = "resample_data", 
        label = "Re-simulate the data",
        icon = icon(name = "refresh", lib = "glyphicon")
      ),
      # Button to click which lets the user download the plot 
      downloadButton(
        outputId = "download_plot",
        label = "Download Plot",
        icon = icon(name = "download-alt", lib = "glyphicon")
      ),
      
      h6("Shiny App created by hotz1")
    )
  )
)

# Define the server-side behaviour to run the Shiny app
server <- function(input, output){
  
  # Simulate the sample data based on the user inputs
  simulate_means <- eventReactive(input$resample_data, {
    simulate_sample_means(
      dist_name = switch(input$distribution,
                         "Beta" = rbeta,
                         "Gamma" = rgamma,
                         "Normal" = rnorm),
      param_1 = input$param_1, 
      param_2 = input$param_2,
      sample_size = input$sample_size,
      simulations = input$n_simulations
    )
  }, ignoreNULL = FALSE)
  
  # Create the plot with the given graphical parameters
  plot_hist <- eventReactive(input$resample_data, {
    plot_sample_means(
      sample_means = simulate_means(), 
      dist_name = input$distribution,
      sample_size = input$sample_size,
      simulations = input$n_simulations,
      bar_fill = input$bin_colour,
      bar_outline = input$bin_outline,
      background = input$hist_background,
      n_bins = input$n_bins
    )
  }, ignoreNULL = FALSE)
  
  # Renders + displays the plot in the Shiny app
  output$means_plot <- renderPlot({plot_hist()})
  
  # Code for the "download plot" button
  output$download_plot <- downloadHandler(
    filename = "sample_means.png",
    content = function(file){
      ggsave(file, plot = plot_hist(), device = "png")
    }
  )
}

# Create the Shiny app
shinyApp(ui, server)