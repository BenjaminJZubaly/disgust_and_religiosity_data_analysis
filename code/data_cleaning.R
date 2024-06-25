# Data Cleaning -----------------------------------------------------------
# This code is called at the beginning of 2024_USRA_analysis_disgust_and_religiosity.qmd,
# so there is no reason to run it on its own.

# Defining the packages to use to clean the data
pkg <- c("tidyverse")

# Loading the groundhog package to install packages from a certain date
library(groundhog)

# Reading in the packages with the groundhog package for reproducibility
  # Message suppressed in order to allow for rendering of quarto document
suppressMessages(groundhog.library(pkg = pkg, date = "2024-06-01"))

# Reading in the unclean data as data.unclean
data.unclean <- read.csv(file = "./data/prepared_data.csv")