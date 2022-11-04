# this is a file full of scratch code
# first I will see how it updates to github
# then I will explore the code using the terra package

library(tidyverse)
library(terra)
library(sf)


# import the michigan counties shapefile from disk
mico <- st_read("C:/Users/mwali/mwalimaa/Projects/SpatialData/Michigan/Counties_v17a/Counties_v17a.shp") %>%
  st_transform(crs = 5070) %>%
  st_union() %>%
  vect()
mi <- st_read("C:/Users/mwali/mwalimaa/Projects/SpatialData/us_state_bounds/tl_2022_us_state.shp") %>%
  st_transform(5070) %>%
  filter(NAME == "Michigan") %>%
  vect()


# import the most recent landfire data and crop mask to mi
us_bps <- rast("C:/Users/mwali/mwalimaa/Projects/SpatialData/LANDFIRE/LF2020_BPS_220_CONUS/Tif/LC20_BPS_220.tif")
us_bps # notice it has a color table

# save color table for later
cols <- coltab(us_bps)
# remove color table from raster
coltab(us_bps) <- NULL

# crop and mask to the shapefile
mi_bps <- crop(us_bps, mi, mask = T)
# reassign color table to raster
coltab(mi_bps) <- cols


plot(mi_bps) # looks good

writeRaster(mi_bps, "C:/Users/mwali/mwalimaa/Projects/SpatialData/LFtest/mi_bps_crop.tif",
            gdal = c("COMPRESS=NONE", "TFW=YES"),
            datatype = "INT2S")