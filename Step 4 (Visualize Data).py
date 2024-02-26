import geopandas as gpd
import pandas as pd
import matplotlib.pyplot as plt

# Membaca data geometri Jawa Timur dari file Shapefile
jawa_timur = gpd.read_file('F:/jatim_kab.shp')

# Membaca data geometri Indonesia dari file Shapefile
indonesia = gpd.read_file('F:/Indo_Kab_Kot.shp')

# Membaca data dari file nasa_power_data_filtered_within.xlsx
data_combined = pd.read_excel('F:/nasa_power_data_filtered_within.xlsx')

# Extract latitude and longitude from the combined data
latitudes = data_combined['Latitude']
longitudes = data_combined['Longitude']

# Membuat plot peta
fig, ax = plt.subplots(figsize=(20, 15))

# Plot peta Indonesia
indonesia.boundary.plot(ax=ax, linewidth=1, color='black')
indonesia.plot(ax=ax, color='white', edgecolor='black')  # Peta Indonesia

# Buat GeoDataFrame dari titik observasi
gdf = gpd.GeoDataFrame(data_combined, geometry=gpd.points_from_xy(data_combined['Longitude'], data_combined['Latitude']))

# Filter titik observasi yang berada di dalam wilayah daratan Jawa Timur
filtered_data = gdf[gdf.within(jawa_timur.unary_union)]

plt.scatter(filtered_data['Longitude'], filtered_data['Latitude'], color='red', marker='o', label=f'Observation Points ({len(filtered_data)})')
plt.title('0.05 x 0.05 Degree, Province of East Java')
plt.xlabel('Longitude')
plt.ylabel('Latitude')

# Plot batas administratif Jawa Timur
jawa_timur.plot(ax=ax, color='none', edgecolor='black')  # Batas administratif Jawa Timur

# Membatasi area untuk fokus ke Jawa Timur
ax.set_xlim(110.794, 116.232)
ax.set_ylim(-9.4127, -6.5352)

# Menampilkan peta
plt.legend()
plt.grid(True)
plt.show()
