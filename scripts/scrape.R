library(rvest)

subiaco <- read_html("http://house.speakingsame.com/p.php?q=Subiaco%2C+WA")

addresses <- subiaco %>%
  html_nodes("span.addr")

# Extract the text content of the selected elements
addresses_text <- html_text(addresses)
print(addresses_text)

# The above works.

test_url <- "http://house.speakingsame.com/p.php?q=Subiaco%2C+WA"

p1data <- bow(test_url) %>% 
  scrape()

p1data %>% 
  html_nodes("span.addr") %>% 
  html_text()

content <- p1data %>% 
  html_nodes("table[style='font-size:13px']")

for (i in seq_along(content)) {
  info <- content[[i]] %>%
    html_nodes("tr") %>%
    html_nodes("td") %>%
    html_text() %>%
    as.character()
}

# Direct copy from python ------

library(rvest)

# Initialize empty vectors/lists
addresses <- c()
properties_info <- list()

# Generate a sequence of page numbers
pages <- seq(0, 3, by = 1)

for (page in pages) {
  # Construct the page URL
  page_url <- paste0("http://house.speakingsame.com/p.php?q=Subiaco&p=", page, "&s=1&st=&type=&count=300&region=Subiaco&lat=0&lng=0&sta=wa&htype=&agent=0&minprice=0&maxprice=0&minbed=0&maxbed=0&minland=0&maxland=0")
  
  # Read the HTML content of the webpage
  webpage <- read_html(page_url)
  
  # Select all <span> elements with class "addr"
  addr_spans <- webpage %>%
    html_nodes("span.addr")
  
  # Extract addresses from the selected <span> elements
  addresses <- c(addresses, html_text(addr_spans))
  
  # Select all <table> elements with style="font-size:13px"
  tables <- webpage %>%
    html_nodes("table[style='font-size:13px']")
  
  # Iterate through the tables and extract property info
  for (i in seq_along(tables)) {
    info <- tables[[i]] %>%
      html_nodes("tr") %>%
      html_nodes("td") %>%
      html_text() %>%
      as.character()
    
    # Add the property info to the properties_info list
    properties_info <- c(properties_info, list(info))
  }
}

# Print the addresses and property info
print(addresses)
print(properties_info)

# Using polite -----
library(polite)
library(rvest)

# Initialize empty vectors/lists
addresses <- c()
properties_info <- list()

# Generate a sequence of page numbers
pages <- seq(0, 3, by = 1)

for (page in pages) {
  # Construct the page URL
  page_url <- paste0("http://house.speakingsame.com/p.php?q=Subiaco&p=", page, "&s=1&st=&type=&count=300&region=Subiaco&lat=0&lng=0&sta=wa&htype=&agent=0&minprice=0&maxprice=0&minbed=0&maxbed=0&minland=0&maxland=0")
  
  # Scrape the webpage
  bow_page <- bow(page_url) %>%
    scrape()
  
  # Select all <span> elements with class "addr"
  addr_spans <- bow_page %>%
    html_nodes("span.addr")
  
  # Extract addresses from the selected <span> elements
  addresses <- c(addresses, html_text(addr_spans))
  
  # Select all <table> elements with style="font-size:13px"
  tables <- bow_page %>%
    html_nodes("table[style='font-size:13px']")
  
  # Iterate through the tables and extract property info
  for (i in seq_along(tables)) {
    info <- tables[[i]] %>%
      html_nodes("tr") %>%
      html_nodes("td") %>%
      html_text() %>%
      as.character()
    
    # Add the property info to the properties_info list
    properties_info <- c(properties_info, list(info))
  }
}

# Print the addresses and property info
print(addresses)
print(properties_info)

# Table cleaning (remove non properties)----

library(tidyverse)
library(stringr)

properties_info_raw <- properties_info
# Filter the properties_info list
subi_clean <- subi %>%
  map(~ if (length(.) > 0 && str_detect(.[1], "^Sold")) {
    .
    } else {
    NULL
    }
    ) %>%
  keep(~ !is.null(.))

subi_clean <- subi %>%
  map(~ if_else((length(.) > 0 && str_detect(.[1], "^Sold")), ., NA)) %>%
  keep(~ !is.null(.))

library(tidyverse)

subi_clean <- subi %>%
  map(~ if_else(length(.) > 0 && str_detect(.[1], "^Sold"), ., character(0))) %>%
  discard(is_empty)


# Print the filtered list
print(sold_properties)

sold_properties %>% 
  html_table()
