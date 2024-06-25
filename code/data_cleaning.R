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

# Format data types
  # IDs as strings
data.unclean$ID <- as.character(data.unclean$ID)
  # Start and finish time as date format
data.unclean <- data.unclean %>%
  mutate(start_time = parse_date_time(start_time, orders = "mdy HM", tz = "UTC")) %>%
  mutate(start_time = as.POSIXct(start_time, origin = "1970-01-01", tz = "UTC"))
data.unclean <- data.unclean %>%
  mutate(finish_time = parse_date_time(finish_time, orders = "mdy HM", tz = "UTC")) %>%
  mutate(finish_time = as.POSIXct(finish_time, origin = "1970-01-01", tz = "UTC"))

# Calculate age (drop down started at 18)
data.unclean$age <- data.unclean$age + 17

# Code sex variable as factor
  # Make them the right numbers
data.unclean$sex <- data.unclean$sex - 1
  # Make it a factor
data.unclean$sex <- factor(data.unclean$sex, 
                           levels = c("0", "1"),
                           labels = c("Male", "Female"))

# Turning gender responses into standardized labels
data.unclean <- data.unclean %>%
  mutate(
    gender = str_trim(gender),  # Remove leading and trailing spaces
    gender = str_to_lower(gender),  # Convert all to lowercase
    gender = case_when(
      gender %in% c("male", "man", "masculine", "xy-male", "boy", "men", "answered above already") ~ "Male",
      gender %in% c("female", "woman", "she/her") ~ "Female",
      gender %in% c("non-binary", "non binary", "nonbinary") ~ "Non-binary",
      gender %in% c("non-binary (agender)", "agender") ~ "Agender",
      gender %in% c("gender fluid") ~ "Gender Fluid",
      gender %in% c("queer") ~ "Gender Queer",
      TRUE ~ NA_character_  # Assign NA to any unclassified responses
    )
  )


















