# Define a function to create a histogram of the sample means
library(tidyverse)
plot_sample_means <- function(sample_means, dist_name, sample_size, simulations, 
                              bar_fill, bar_outline, background, n_bins){
  # Coerce data to a tibble
  sample_tibble <- tibble(mean = sample_means)
  
  # Create the histogram with the specified graphical parameters
  sample_mean_hist <- sample_tibble %>%
    ggplot(aes(x = sample_means, y = after_stat(density))) +
    geom_histogram(bins = n_bins, fill = bar_fill, color = bar_outline) +
    labs(x = "Sample Mean", y = "Density", 
         title = paste0("Histogram of sample means of size n = ", sample_size),
         subtitle = paste0("Based on ", simulations, " simulations from a ",
                           dist_name, " distribution")) +
    theme(panel.background = element_rect(fill = background)) +
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5))
  
  return(sample_mean_hist)
}
