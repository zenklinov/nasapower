import geopandas as gpd
import pandas as pd

# Read  geometri data Jawa Timur from Shapefile
jawa_timur = gpd.read_file('F:/jatim_kab.shp')

# Initiate empty dataframe
data_combined = pd.DataFrame()

# Loop to read data from part 1 hingga part 19
for part_number in range(1, 20):
    part_filename = f'F:/nasa_power_data_pivoted_part{part_number}.xlsx'
    data_part = pd.read_excel(part_filename)
    
    # Combine data from recent part with previous data
    data_combined = pd.concat([data_combined, data_part])

# Extract latitude and longitude from the combined data
latitudes = data_combined['Latitude']
longitudes = data_combined['Longitude']

# Create map plot
fig, ax = plt.subplots(figsize=(20, 15))
jawa_timur.boundary.plot(ax=ax, linewidth=1, color='black')

# Create GeoDataFrame from observation points
gdf = gpd.GeoDataFrame(data_combined, geometry=gpd.points_from_xy(data_combined['Longitude'], data_combined['Latitude']))

# Filter observation points within region
filtered_data = gdf[gdf.within(jawa_timur.unary_union)]

# exclude column 'geometry' before save to Excel
filtered_data = filtered_data.drop(columns='geometry')

# Save data to Excel
output_filename = 'F:/nasa_power_data_filtered_within.xlsx'
filtered_data.to_excel(output_filename, index=False)

