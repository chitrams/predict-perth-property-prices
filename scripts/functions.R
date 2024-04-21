scrape_addresses <- function(suburb, page_end){
  
  suburb_name <- gsub(" ", "+", suburb)
  
  # Initialize empty vectors/lists
  addresses <- c()
  
  # Generate a sequence of page numbers
  pages <- seq(0, page_end, by = 1)
  
  for (page in pages) {
    # Construct the page URL
    page_url <- paste0("http://house.speakingsame.com/p.php?q=", suburb_name, "&p=", page, "&s=1&st=&type=&count=300&region=", suburb_name, "&lat=0&lng=0&sta=wa&htype=&agent=0&minprice=0&maxprice=0&minbed=0&maxbed=0&minland=0&maxland=0")
    
    # Scrape the webpage
    bow_page <- bow(page_url) %>%
      scrape()
    
    # Select all <span> elements with class "addr"
    addr_spans <- bow_page %>%
      html_nodes("span.addr")
    
    # Extract addresses from the selected <span> elements
    addresses <- c(addresses, html_text(addr_spans))
  }
  
  addresses
}

scrape_property_info <- function(suburb, page_end){
  
  suburb_name <- gsub(" ", "+", suburb)
  
  # Initialize empty vectors/lists
  properties_info <- list()
  info <- c()
  
  # Generate a sequence of page numbers
  pages <- seq(0, page_end, by = 1)
  
  for (page in pages) {
    # Construct the page URL
    page_url <- paste0("http://house.speakingsame.com/p.php?q=", suburb_name, "&p=", page, "&s=1&st=&type=&count=300&region=", suburb_name, "&lat=0&lng=0&sta=wa&htype=&agent=0&minprice=0&maxprice=0&minbed=0&maxbed=0&minland=0&maxland=0")
    
    # Scrape the webpage
    bow_page <- bow(page_url) %>%
      scrape()
    
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
  
  properties_info
  
  properties_info_cleaned <- properties_info %>% 
    map(~ if (length(.) > 0 && str_detect(.[1], "^Sold")) {
      .
    } else {
      NULL
    }) %>%
    keep(~ !is.null(.))
  
  properties_info_cleaned
}

make_df_properties <- function(list_properties) {
  
  # Convert the list properties to a data frame
  max_length <- max(lengths(list_properties))
  
  # Pad each sublist with NA values to match the maximum length
  padded_properties <- lapply(list_properties, function(x) {
    if(length(x) < max_length) {
      c(x, rep(NA, max_length - length(x)))
    } else {
      x
    }
  })
  
  # Convert the padded properties to a data frame
  df <- as.data.frame(do.call(rbind, padded_properties))
  
  # Return the resulting data frame
  df
  
}