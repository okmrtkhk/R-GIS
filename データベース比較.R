library(tidyverse)
setwd("Documents/GitHub/R-GIS/")
#国土数値情報ダウンロードサービス
#宮城県 R4年度版
mlit <- 
  sf::read_sf("N03-20220101_04_GML/N03-22_04_220101.shp") %>% 
  ggplot()+
  geom_sf()
# Natural Earth Cultural Vectors admin 1
# ver. 5.1.1
nut.earth <-
  sf::read_sf(
    paste0("ne_10m_admin_1_states_provinces/",
           "ne_10m_admin_1_states_provinces.shp")) %>% 
  filter(name_local == "宮城県") %>% 
  ggplot()+
  geom_sf()
# esri 
# ver. 8.4
esri <-
  sf::read_sf("japan_ver84/japan_ver84.shp") %>% 
  filter(KEN == "宮城県") %>% 
  ggplot()+
  geom_sf()
g <- 
  cowplot::plot_grid(
    mlit, nut.earth, esri,
    labels = c("A", "B", "C"))
cowplot::save_plot(
  filename = "Miyagi.svg",
  plot = g)
