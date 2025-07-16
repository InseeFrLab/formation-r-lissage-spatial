# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#          Préparation des données pour formation lissage 2022
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

library(data.table)
library(sf)

# ***********************************
#             Données DVF
# ***********************************

# URL : "https://files.data.gouv.fr/geo-dvf/latest/csv/2021/"
# Téléchargement de la base full.csv

dvf75 <- fread("data/donnees/full.csv",encoding = "UTF-8")

# Filtres
dvf75 <- dvf75[code_departement %in% c('75','92','93','94')]
dvf75 <- dvf75[type_local %in% c("Appartement","Maison")]
dvf75 <- dvf75[!is.na(valeur_fonciere) & valeur_fonciere > 10000 & valeur_fonciere < 10000000]
dvf75 <- dvf75[nature_mutation == "Vente"]
dvf75 <- dvf75[!is.na(longitude) | !is.na(latitude)]
dvf75 <- dvf75[nombre_pieces_principales>0]
# Supression doublons d'id mutation
dvf75 <- dvf75[!duplicated(dvf75$id_mutation),]
# Selection des variables
dvf75 <- dvf75[,.(id_mutation,date_mutation,type_local,nombre_pieces_principales,valeur_fonciere,surface_reelle_bati,longitude,latitude)]

# Transformation des coordonnées en Lambert 93
dvf75_sf <- st_as_sf(dvf75,coords = c("longitude","latitude"),crs=4326)
dvf75_sf <- st_transform(dvf75_sf,2154)
dvf75$x <- st_coordinates(dvf75_sf)[,1] 
dvf75$y <- st_coordinates(dvf75_sf)[,2]
dvf75 <- dvf75[,-c("longitude","latitude")]

saveRDS(dvf75,"data/donnees/ventesImmo_couronneParis.RDS")

# *************************************************
#    Contours département petite couronne Paris
# *************************************************

# Source Applishare : dep_francemetro_2021.shp

depSf <- read_sf("data/fondsDeCarte/dep/dep_francemetro_2021.shp")
depCouronneSf <- depSf[depSf$code %in% c('75','92','93','94'),]
write_sf(depCouronneSf,"data/fondsDeCarte/depCouronne.shp") 

# ****************************************
#         Parkings de Bordeaux
# ****************************************

# Source : https://opendata.bordeaux-metropole.fr/explore/dataset/st_park_p/information/?location=14,44.83244,-0.57022&basemap=jawg.streets

parking <- st_read("data/donnees/st_park_p.shp")

# Imputation des valeurs manquantes sur les prix
tarif_moy <- mean(parking$th_heur,na.rm = T)
parking$th_heur[is.na(parking$th_heur)] <- tarif_moy

# Transformation en fichier place avec coordonnées en Lambert93
parking <- parking %>% 
  st_transform(2154) %>%  
  select(ident,exploit,np_global,np_pmr,th_heur) %>% 
  mutate(x=st_coordinates(geometry)[,1],
         y=st_coordinates(geometry)[,2],
         epsg="2154") %>%
  st_drop_geometry()

parking <- saveRDS(parking,"data/donnees/parking.RDS")








