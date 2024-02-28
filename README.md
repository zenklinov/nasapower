# NASA POWER DATA
Getting Data NASA POWER, such as Precipitation in Regional by Single Point approach.

Here, you'll find a versatile codebase for retrieving NASA Power data from regional grids. This code allows you to customize various parameters, such as time and temporal averages, communities, and specific data parameters like precipitation, temperatures, and more. The regional grid you work with is derived from a single-point approach, making it highly adaptable to your specific research or application needs.

Key Features:

1. Retrieve NASA Power data from regional grids. Utilize a single-point approach for regional grid adaptation.
2. Customize time intervals and temporal averages.
3. Select specific communities of interest (modify data parameters, including precipitation, temperatures, and more).

# NASA POWER Data Processing Pipeline

This repository contains scripts for processing NASA POWER (Prediction Of Worldwide Energy Resources) data. The data processing pipeline consists of four main steps: getting data, pivoting data, combining and filtering data, and visualizing data. The data retrieved in this project is from the NASA POWER (Prediction Of Worldwide Energy Resources) database. Specifically, the data pertains to precipitation or rainfall, represented by the parameter code "PRECTOTCORR". This data provides information about total precipitation corrected for gauge and other biases. Below are the details of each step:

## Path 1: Step 1 (Getting Data)

File: `Step 1 (Getting Data).r`

This R script retrieves NASA POWER data for precipitation (parameter code: PRECTOTCORR) for a specified geographical area and time range. It divides the area into smaller parts, downloads the data for each part, and saves it into separate Excel files.

### Instructions
1. Install and load the necessary R packages: `nasapower` and `writexl`.
2. Define the parameter code, date range, and geographical coordinates.
3. Run the script to download and save the data into Excel files.

## Path 2: Step 2 (Pivot Data)

After downloading the data, it is pivoted from wide to long format. This transformation allows for easier analysis and visualization of the data, with longitude and latitude becoming rows and dates becoming columns.

File: `Step 2 (Pivot Data).r`

This R script pivots the downloaded NASA POWER data from wide to long format, where longitude and latitude become rows and dates become columns. It iterates through the downloaded Excel files from Step 1 and saves the pivoted data into new Excel files.

### Instructions
1. Install and load the necessary R package: `writexl`.
2. Specify the base path for input and output files.
3. Run the script to pivot the data and save it into new Excel files.

## Path 3: Step 3 (Combined and Filtered Data)

File: `Step 3 (Combined and Filtered Data).py`

This Python script combines the pivoted NASA POWER data from Step 2 and preprocesses it. It filters the data points within a specific geographical region (Jawa Timur) using shapefile data and plots the observation points on a map. Finally, it saves the filtered data into an Excel file.

### Instructions
1. Install and import the necessary Python libraries: `geopandas` and `pandas`.
2. Read geometrical data for Jawa Timur from a shapefile.
3. Combine and preprocess the data from Step 2.
4. Plot observation points on a map.
5. Save the filtered data into an Excel file.

## Path 4: Step 4 (Visualize Data)

File: `Step 4 (Visualize Data).py`

This Python script visualizes the filtered NASA POWER data within the geographical region of Jawa Timur. It reads shapefile data for Jawa Timur and Indonesia, as well as the filtered data from Step 3, and plots the observation points on a map.

### Instructions
1. Install and import the necessary Python libraries: `geopandas`, `pandas`, and `matplotlib`.
2. Read geometrical data for Jawa Timur and Indonesia from shapefiles.
3. Read filtered data from Step 3.
4. Plot observation points on a map within the geographical boundaries of Jawa Timur.
5. Display the map.

## Data Files

### Step 1: Getting Data
- `nasa_power_data_part1.xlsx` to `nasa_power_data_part19.xlsx`: Excel files containing downloaded NASA POWER data parts.

### Step 2: Pivot Data
- `nasa_power_data_pivoted_part1.xlsx` to `nasa_power_data_pivoted_part19.xlsx`: Excel files containing pivoted NASA POWER data parts.

### Step 3: Combined and Filtered Data
- `nasa_power_data_filtered_within.xlsx`: Filtered NASA POWER data within the geographical region of Jawa Timur.

### Step 4: Visualize Data
- `Indo and Jatim Kab_Kot SHP 2019.part01.rar` to `Indo and Jatim Kab_Kot SHP 2019.part06.rar`: RAR files containing shapefiles for Indonesia and Jawa Timur Kabupaten/Kota (districts) for the year 2019.

  Note: Shapefiles are compressed into multiple parts for easier distribution and download. Please make sure to extract all parts before use.

- [Jawa Timur Map](https://github.com/zenklinov/nasapower/blob/main/output_map.png): Map of Jawa Timur after data processing in Step 4.
![Jawa Timur Map](https://github.com/zenklinov/nasapower/blob/main/output_map.png)

---

Feel free to explore each step and adapt the scripts to your specific requirements.


