# Address rule -----

# First col is always an address. Save to address col

# Price rule -----

# If starts with "Sold $", save to price col
# In same cell, "in[::alphanum::]$" saves to date col

# If exists starts with "Last Sold $", 
# Create new column and save to price col
# In same cell, "in[::alphanum::]$" saves to date col

# Property type rule -----

# First, save type.
# Starting with Unit, Apartment, House, Townhouse, Land, or Commercial Property
# and ending in : or : and (digit)
# but not "Land size: 620 sqm" 
# ie Land size: ddd sqm


# Bed, bath, park -----

# - bedrooms col
# - bathrooms col
# - parking col

# Size -----

# If starting with:
# Unit
# Apartment
# House
# Townhouse
# and ends in m:,
# save this as property_size

# - property_size col (the one unit or townhouse "living" size)
# - building_size col (if block of apartments, this is the building)
# - land_size col