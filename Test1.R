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
  filter( region == "Mexico", is.na(subregion)) -> baja
datatable( baja )

ggplot() +
  geom_polygon( aes(long,lat), fill="grey", data=baja) +
  geom_point( aes(Longitude,Latitude), data=araptus) +
  xlab("Longitude") + ylab("Latitude") +
  coord_map()

names(araptus_sf)
plot(araptus_sf)

library(leaflet)
leaflet(araptus) %>%
  addProviderTiles( providers$Esri.WorldImagery) %>%
  addCircleMarkers( radius = ~Suitability*10, color="red", label = ~Site)


library(leaflet.minicharts)
leaflet(araptus) %>%
  addProviderTiles( providers$Esri.WorldImagery) %>%
  addMinicharts(araptus$Longitude, araptus$Latitude, type="pie", 
                chartdata=araptus[, c("Males", "Females")],
                                  width= araptus$Suitability*30)
