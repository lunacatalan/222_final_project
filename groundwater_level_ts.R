library(tidyverse)
library(readr)
library(here)

gw_level_total <- readxl::read_xlsx(here("data/groundwater_time_series.xlsx")) %>% 
  select(Year, WaterLevel) %>% # select years
  separate_wider_delim(col = Year, 
                       ".", # separate the months
           names = c("Year", "Month")) %>% 
  select(!Month) %>% # remove the decimal column 
  mutate_at(vars(Year), as.numeric)

# these are the mean depth to groundwater level
gw_mean <- gw_level_total %>% 
  group_by(Year) %>% 
  summarize(mean = mean(WaterLevel))

# unique(gw_level_total$Year)

ggplot() +
  geom_point(data = gw_mean,
            aes(x = Year, 
                y = mean))
