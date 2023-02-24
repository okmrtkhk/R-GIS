library(tidyverse)
# 国土数値情報ダウンロードサービス：行政区界
map <- sf::read_sf(
  "GIS_DB/nlftp/district/N03-20220101_GML/N03-22_220101.shp") %>% 
  select(N03_001, geometry) %>% 
  # ポリゴンの処理は直交座標系が圧倒的に早いので変換
  # ただし、2451系でない領域もこれで処理しているので、検証が必要
  sf::st_transform(crs = 2451) %>% 
  # 小さい島などを除去する操作
  sf::st_cast(., "POLYGON") %>% 
  mutate(area.size = sf::st_area(geometry)) %>% 
  filter(area.size > units::set_units(10^7, "m^2")) %>% 
  # 都道府県名称でnestし、含まれるポリゴンを結合、都道府県境界を作成する
  group_nest(N03_001) %>% 
  mutate(pref = map(data, ~sf::st_union(.x))) %>% 
  mutate(pref = map(pref, sfheaders::sf_remove_holes)) %>% 
  unnest(pref) %>% 
  sf::st_set_geometry("pref") %>% 
  select(pref = N03_001, geometry = pref) %>% 
  rmapshaper::ms_simplify() %>% 
  sf::st_transform(crs = 4326)

ggplot(map)+
  geom_sf()+
  coord_sf(xlim = c(141,143), ylim = c(38,40))

