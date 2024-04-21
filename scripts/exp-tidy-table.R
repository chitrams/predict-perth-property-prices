library(tidyverse)

# Initialize an empty list to store properties
Properties <- list()

# Loop over each address
for (i in seq_along(addresses)) {
  
  # Create a dataframe to store property details for each address
  Property_df <- tibble(
    address = addresses[i],
    strings = sold_properties[[i]]
  )
  
  # Extract property details using tidyverse functions
  Property_df <- Property_df %>%
    separate(strings, into = c("detail", "value"), sep = " ") %>%
    mutate(
      category = case_when(
        detail == "Sold" ~ "sold",
        detail %in% c("Apartment:", "House:", "Townhouse:") ~ "type",
        detail == "Agent:" ~ "agent",
        detail == "Rent" ~ "rent",
        detail == "Land" & value == "size:" ~ "land_size",
        detail == "Building" & value == "size:" ~ "building_size"
      )
    ) %>%
    pivot_wider(names_from = category, values_from = value)
  
  # Add the property details dataframe to the list of properties
  Properties[[i]] <- Property_df
  
}

# Print the list of properties
Properties

df_houses <- bind_rows(Properties)
