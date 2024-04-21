library(targets)
library(tarchetypes)

# Custom functions
source("R/functions.R")

# Set target-specific options such as packages:
tar_option_set(
  packages = c("tidyverse",
               "stringr",
               "rvest",
               "polite")
  ) 

# End this file with a list of target objects.
list(
  
  # User selection: suburb name and number of pages (starting with 0)
  tar_target(
    suburb,
    suburb <- "Shenton Park"
  ),
  
  tar_target(
    page_end,
    page_end <- "1"
  ),
  
  # Run some functions
  tar_target(
    suburb_addresses,
    scrape_addresses(
      suburb = suburb, 
      page_end = page_end)
  ),
  
  tar_target(
    property_info,
    scrape_property_info(
      suburb = suburb, 
      page_end = page_end)
  )
)
