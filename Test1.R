library(scape)
data("araptus")
summary(araptus)

library(sf)
const <- st_point( c( -111.7, 26.14) )
st_as_text(const)
st_as_binary(const)

araptus_sf <- st_as_sf(araptus,coords = c("Longitude", "Latitude"))
araptus_sf
st_crs(araptus_sf)

st_crs(araptus_sf) <- 3857
araptus_sf

st_bbox(araptus_sf)

library(ggplot2)
library(dplyr)
library(DT)
map_data("world") %>%
  filert( region == "Mexico", is.na(subregion)) -> baja
