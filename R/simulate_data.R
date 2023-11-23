# Define a function to simulate sample means of a given sample size
simulate_sample_means <- function(dist_name, param_1, param_2,
                                  sample_size, simulations){
  # Vector of sample means
  sample_means <- rep(NA, simulations)

  # Simulate IID samples from the chosen distribution and compute sample mean
  for(i in 1:simulations){
    sample_data <- dist_name(sample_size, param_1, param_2)
    sample_means[i] <- mean(sample_data)
  }

  return(sample_means)
}
