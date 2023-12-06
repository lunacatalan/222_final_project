# This was Before 

# all technologies together, ie complete crop
iran_TA <- read.dbf("/Users/lunacatalan/Documents/dev/eds222/project/222_final_project/data/spam2010v2r0_global_prod.dbf/spam2010V2r0_global_P_TA.DBF") %>% 
  filter(ISO3 == "IRN")


#str(iran_TA)
#summary(iran_TA)



# to read in the .tif files use this format
rootdir <- ("/Users/lunacatalan/Documents/dev/eds222/project/222_final_project/data/spam2010v2r0_global_prod.geotiff/") # print getwd()
global_acof_a = rast(file.path(rootdir, "spam2010V2r0_global_P_ACOF_A.tif"))

plot(global_acof_a)



Got this data from: https://zenodo.org/records/7809342
Area Equipped for Irrigation
"international  databases,  national  agricultural  censuses, 63and  government  reports.  We  then  combine  these  data  with  global  gridded  maps  of  cropland20, 64pastureland20,  and  irrigated  area21into  a  spatial  allocation  and  downscaling  model12to  develop  global 65gridded (5 arc-min) maps of AEI for the year 2000, 2005, 2010, and 2015"

# need a different library for this 
library(raster)
library(terra)
# install.packages("devtools")
#devtools::install_github("tcarleton/stagg")
library(stagg)



# Made Qazvin bbox Geometry 

```{r}
qazvin_box <- data.frame(name = c("1", "2", "3", "4"),
                         long = c(49.31937729228426, 49.31937729228426, 51.12523623049739, 51.12523623049739),
                         lat = c(36.493217304744505, 35.52665079679184, 35.52665079679184, 36.493217304744505))

qazvin_box = st_polygon(list(
  cbind(
    qazvin_box$long[c(1, 2, 3, 4, 1)],
    qazvin_box$lat[c(1, 2, 3, 4, 1)]
  )
))

# need to set crs
qazvin_box <- st_sfc(qazvin_box,
                     crs = st_crs(asc_2015))



# list files for each band, including the full file path
filelist <- list.files(here("data/AEI_ASC/"), # say what folder to read the files in 
                       full.names = TRUE)

# read in and store as a raster stack
asc_1900_2015 <- rast(filelist) %>% 
  crop(., qazvin_box)

plot(asc_1900_2015)

date <- c("1900", "1910", "1920", "1930", "1940", "1950", "1960", "1970", "1980", "1985", "1990", "1995", "2000", "2005", "2010", "2015")

asc_mean <- data.frame(mean = (asc_1900_2015, "mean"))
```

Aquifer boundary: https://www.sciencedirect.com/science/article/pii/S2352801X20301818#fig1

Steps:
  - georeference the qazvin aquifer
- make into a .shp file 
- clip the raster to that shp --> make the .shp into a mask


```{r eval = FALSE}
rootdir <- ("/Users/lunacatalan/Documents/dev/eds222/project/222_final_project/data/AEI_ASC/")
asc_2015 <- rast(file.path(rootdir, "MEIER_G_AEI_2015.ASC"))
asc_2010 <- rast(file.path(rootdir, "MEIER_G_AEI_2010.ASC"))
asc_2005 <- rast(file.path(rootdir, "MEIER_G_AEI_2005.ASC"))
asc_2000 <- rast(file.path(rootdir, "MEIER_G_AEI_2000.ASC"))
asc_1995 <- rast(file.path(rootdir, "MEIER_G_AEI_1995.ASC"))
asc_1990 <- rast(file.path(rootdir, "MEIER_G_AEI_1990.ASC"))
asc_1985 <- rast(file.path(rootdir, "MEIER_G_AEI_1985.ASC"))
asc_1980 <- rast(file.path(rootdir, "MEIER_G_AEI_1980.ASC"))
asc_1970 <- rast(file.path(rootdir, "MEIER_G_AEI_1970.ASC"))
asc_1960 <- rast(file.path(rootdir, "MEIER_G_AEI_1960.ASC"))
asc_1950 <- rast(file.path(rootdir, "MEIER_G_AEI_1950.ASC"))
asc_1940 <- rast(file.path(rootdir, "MEIER_G_AEI_1940.ASC"))
asc_1930 <- rast(file.path(rootdir, "MEIER_G_AEI_1930.ASC"))
asc_1920 <- rast(file.path(rootdir, "MEIER_G_AEI_1920.ASC"))
asc_1910 <- rast(file.path(rootdir, "MEIER_G_AEI_1910.ASC"))
asc_1900 <- rast(file.path(rootdir, "MEIER_G_AEI_1900.ASC"))

plot(asc_2015)

# check crs 
st_crs(asc_2015)

qazvin_2015 <- crop(asc_2015, qazvin_box)
qazvin_2010 <- crop(asc_2010, qazvin_box)
qazvin_2005 <- crop(asc_2005, qazvin_box)
qazvin_2000 <- crop(asc_2000, qazvin_box)
qazvin_1995 <- crop(asc_1995, qazvin_box)
qazvin_1990 <- crop(asc_1990, qazvin_box)
qazvin_1985 <- crop(asc_1985, qazvin_box)
qazvin_1980 <- crop(asc_1980, qazvin_box)
qazvin_1970 <- crop(asc_1970, qazvin_box)
qazvin_1960 <- crop(asc_1960, qazvin_box)
qazvin_1950 <- crop(asc_1950, qazvin_box)
qazvin_1940 <- crop(asc_1950, qazvin_box)
qazvin_1930 <- crop(asc_1950, qazvin_box)
qazvin_1920 <- crop(asc_1950, qazvin_box)
qazvin_1910 <- crop(asc_1910, qazvin_box)
qazvin_1900 <- crop(asc_1900, qazvin_box)

plot(qazvin_2015)
plot(qazvin_2010)
plot(qazvin_2005)
plot(qazvin_2000)
plot(qazvin_1995)
plot(qazvin_1990)
plot(qazvin_1960)
plot(qazvin_1900)

```