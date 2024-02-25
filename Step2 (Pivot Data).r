# Load the required package
if (!require("writexl")) {
  install.packages("writexl")
  library(writexl)
}

# Specify the base path for the input and output files
base_path <- "F:\\nasa_power_data_part"

# Loop through the 19 parts
for (part in 1:19) {
  # Construct the input and output file paths for the current part
  input_file_path <- paste0(base_path, part, ".xlsx")
  output_file_path <- paste0("F:\\nasa_power_data_pivoted_part", part, ".xlsx")
  
  # Load the data from the Excel file
  data <- readxl::read_excel(input_file_path)
  
  # Pivot the data to get lon and lat as rows and dates as columns
  pivoted_data <- reshape2::dcast(data, Latitude + Longitude ~ YYYYMMDD, value.var = "PRECTOTCORR")
  
  # Save the pivoted data to a new Excel file
  write_xlsx(pivoted_data, output_file_path)
  
  # Print a message indicating where the new file is saved
  cat("Transformed data for part", part, "saved to", output_file_path, "\n")
}
