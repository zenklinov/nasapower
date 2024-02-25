# Install and load the necessary packages
if (!require("nasapower")) {
  install.packages("nasapower")
  library(nasapower)
}
if (!require("writexl")) {
  install.packages("writexl")
  library(writexl)
}

# Define the parameter code for precipitation (PRECTOTCORR)
parameter_code <- "PRECTOTCORR"

# Define the date range
start_date <- "2018-01-01"
end_date <- "2022-12-31"

# Define the starting and ending coordinates
start_latitude <- -8.8604
end_latitude <- -6.6998
start_longitude <- 110.887
end_longitude <- 116.062

# Generate a list of latitude and longitude coordinates
latitude_values <- seq(start_latitude, end_latitude, by = 0.05)
longitude_values <- seq(start_longitude, end_longitude, by = 0.05)

# Create an empty data frame to store the data
all_data <- data.frame()

# Set the maximum number of lon lat per part
lon_lat_per_part <- 250

# Initialize a counter for lon lat
lon_lat_counter <- 0

# Create a list to store data frames for each part
data_frames <- list()

# Initialize part number
part_number <- 1

# Loop through latitude
for (latitude in latitude_values) {
  # Loop through longitude
  for (longitude in longitude_values) {
    # Download data for the current latitude and longitude
    data <- nasapower::get_power(
      community = "AG",
      lonlat = c(longitude, latitude),
      pars = parameter_code,
      dates = c(start_date, end_date),
      temporal_api = "daily"
    )
    
    # Combine latitude and longitude with data
    data$Latitude <- latitude
    data$Longitude <- longitude
    
    # Append the data to the current data frame
    data_frames[[lon_lat_counter + 1]] <- data
    
    # Increment the lon lat counter
    lon_lat_counter <- lon_lat_counter + 1
    
    # If lon lat counter reaches the limit, save the data to a new Excel file
    if (lon_lat_counter == lon_lat_per_part) {
      # Create a file name with part number
      output_file_name <- paste(
        "nasa_power_data_part", part_number, ".xlsx", sep = ""
      )
      
      # Specify the output file path
      output_file_path <- file.path("F:\\", output_file_name)
      
      # Merge data frames and save to Excel
      merged_data <- do.call(rbind, data_frames)
      write_xlsx(merged_data, output_file_path)
      
      # Print a message indicating the part number
      cat("Downloaded and saved Part", part_number, "of NASA POWER data\n")
      
      # Reset the lon lat counter, data frames, and increment part number
      lon_lat_counter <- 0
      data_frames <- list()
      part_number <- part_number + 1
    }
  }
}

# If there are remaining data, save to a new Excel file
if (length(data_frames) > 0) {
  # Create a file name for the last part
  output_file_name <- paste(
    "nasa_power_data_part", part_number, ".xlsx", sep = ""
  )
  
  # Specify the output file path
  output_file_path <- file.path("F:\\", output_file_name)
  
  # Merge data frames and save to Excel
  merged_data <- do.call(rbind, data_frames)
  write_xlsx(merged_data, output_file_path)
  
  # Print a message indicating the part number
  cat("Downloaded and saved Part", part_number, "of NASA POWER data\n")
}

# Print a final message
cat("All parts of NASA POWER data downloaded and saved.")
