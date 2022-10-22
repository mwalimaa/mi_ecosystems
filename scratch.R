# this is a file full of scratch code
# first I will see how it updates to github
# then I will explore the code using the terra package

library(tidyverse)
library(sf)
library(raster)
library(terra) # not gonna use terra


# import the michigan counties shapefile from disk
mico <- st_read("C:/Users/mwali/mwalimaa/Projects/SpatialData/Michigan/Counties_v17a/Counties_v17a.shp") %>%
  st_transform(crs = 5070)
mi <- st_union(mico) %>%
  st_sf()

# import the most recent landfire data and crop mask to mi
us_bps <- terra::rast("C:/Users/mwali/mwalimaa/Projects/SpatialData/LANDFIRE/LF2020_BPS_220_CONUS/Tif/LC20_BPS_220.tif")

plot(us_bps)


bps_c <- us_bps %>% terra::crop(mi) # not working







###########################################33

us_evt <- terra::rast("C:/Users/mwali/mwalimaa/Projects/SpatialData/LANDFIRE/LF2020_EVT_220_CONUS/Tif/LC20_EVT_220.tif")

# crop and mask rasters to mi
mi_bps <- us_bps %>%
  crop(mi) %>%
  mask(mi)
mi_evt <- us_evt %>%
  crop(mi) %>%
  mask(mi)