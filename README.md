# assignment-b3-hotz1

## What is this repository?

This repository contains files which I created for the third assignment ("Assignment B-3") of STAT 545B at the University of British Columbia. For this project, we were tasked with creating a Shiny app using R and RStudio which has at least three interactive features that users can interact with.

The Shiny app which I created is hosted on [shinyapps.io](https://www.shinyapps.io/), and my Shiny app is called [Central Limit Theorem Simulator](https://hotz1.shinyapps.io/assignment-b3-hotz1/).

## What does the Shiny app do?

The Shiny app which is created from the R scripts in this repository allows users to view a histogram of simulated sample means of three common continuous probability distributions; the Beta Distribution, the Gamma Distribution, and the Normal Distribution.

The Shiny app is highly interactive, as it allows users to change the sampling distribution, the size of the samples, the number of simulated sample means, and the colours of the histogram. Additionally, the app has a "re-simulate" button which re-runs all of the code to generate a new sample and a new histogram, and a button which allows users to download the generated histogram locally as a PNG file.

## What are the files and folders in this repository?

This repository contains three R script (`.R`) files, a Markdown (`.md`) file, and one gitignore file. You are free to view the files in the repository if you wish, but it is recommended to look at these files with the Shiny app open so you can understand how the code in these scripts effect the app's outputs and features.

Here is some more detailed information about each of the files in this repository:
- [`app.R`](https://github.com/stat545ubc-2023/assignment-b3-hotz1/blob/main/app.R): This R script defines the behaviour and features of the Shiny app and the code which utilizes the user-supplied inputs from the app to generate the corresponding outputs.
- [`R/simulate_data.R`](https://github.com/stat545ubc-2023/assignment-b3-hotz1/blob/main/R/simulate_data.R): This R script defines a helper function called `simulate_sample_means` which creates a vector of sample means based on the inputs provided by the user.
- [`R/plot_sample_means.R`](https://github.com/stat545ubc-2023/assignment-b3-hotz1/blob/main/R/plot_sample_means.R): This R script defines a helper function called `plot_sample_means` which uses `ggplot2` to create a histogram of the simulated sample means.
- [`README.md`](https://github.com/stat545ubc-2023/assignment-b3-hotz1/blob/main/README.md): This is the README file which you are reading at the moment. This file is a standard README file for a GitHub repository, which is useful for orienting yourself with the files in the repository.
- [`.gitignore`](https://github.com/stat545ubc-2023/assignment-b3-hotz1/blob/main/.gitignore): This file ensures that the Git repository does not include any unneeded files which are in the local copy of this repository, such as the files which are used for deploying the Shiny app on [shinyapps.io](https://www.shinyapps.io/).

## How do I use this repository?

Great question! It is recommended to first test out the [Central Limit Theorem Simulator](https://hotz1.shinyapps.io/assignment-b3-hotz1/) Shiny app to get an understanding of the app and its features before viewing the code behind the app in greater detail.

If you would like to edit any of the features of the app, it is best to clone the entire repository into a new blank folder and edit the three R scripts (or add new R scripts to define additional functions) as necessary. If you would like more information about developing R Shiny apps, you may find it helpful to look at the [R Shiny Basics](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/index.html) webpage to get a better understanding of the different facets of the Shiny app.
